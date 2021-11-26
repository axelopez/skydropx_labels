module RequestsLabels
    class ZipGenerator
        attr_reader :request_labels
        def start
          require "open-uri"
          require 'zip'
          request_labels.status = "processing"
          request_labels.save

          labels = JSON.parse(request_labels.request)

          if request_labels.request_label_details.count == 0
            labels.each do |label|
              begin
                resultado = RequestsLabels::Carriers::Carrier.get_label label
                if resultado[:result]

                     request_label_detail = RequestLabelDetail.new
                     request_label_detail.request_label_id = request_labels.id
                     request_label_detail.status = "generated"
                     request_label_detail.file_url = resultado[:data][:file_url]
                     request_label_detail.shipment_id = resultado[:data][:shipment_id]
                     request_label_detail.tracking_number = resultado[:data][:tracking_number]
                     request_label_detail.carrier = label["carrier"]
                     request_label_detail.result = "Generation completed!"
                     request_label_detail.json = label.to_json

                     request_label_detail.save!

                else

                     request_label_detail = RequestLabelDetail.new
                     request_label_detail.request_label_id = request_labels.id
                     request_label_detail.status = "error"
                     request_label_detail.file_url = nil
                     request_label_detail.shipment_id = nil
                     request_label_detail.tracking_number = nil
                     request_label_detail.carrier = label["carrier"]
                     request_label_detail.result = resultado[:error]
                     request_label_detail.json = label.to_json

                     request_label_detail.save!
                end
              rescue => error
                    request_label_detail = RequestLabelDetail.new
                    request_label_detail.request_label_id = request_labels.id
                    request_label_detail.status = "error"
                    request_label_detail.file_url = nil
                    request_label_detail.shipment_id = nil
                    request_label_detail.tracking_number = nil
                    request_label_detail.carrier = label["carrier"]
                    request_label_detail.result = error.message
                    request_label_detail.json = label.to_json

                    request_label_detail.save!
              end
            end
          else
            request_labels.request_label_details.each do |label|
               if label.status != "generated"
                 puts label.status
                 puts label.json
                  begin
                    resultado = RequestsLabels::Carriers::Carrier.get_label JSON.parse(label.json)
                    if resultado[:result]


                        label.request_label_id = request_labels.id
                        label.status = "generated"
                        label.file_url = resultado[:data][:file_url]
                        label.shipment_id = resultado[:data][:shipment_id]
                        label.tracking_number = resultado[:data][:tracking_number]
                        label.carrier = label["carrier"]
                        label.result = "Generation completed!"


                        label.save!

                    else


                        label.request_label_id = request_labels.id
                        label.status = "error"
                        label.file_url = nil
                        label.shipment_id = nil
                        label.tracking_number = nil
                        label.carrier = label["carrier"]
                        label.result = resultado[:error]


                        label.save!
                    end
                  rescue => error

                        label.request_label_id = request_labels.id
                        label.status = "error"
                        label.file_url = nil
                        label.shipment_id = nil
                        label.tracking_number = nil
                        label.carrier = label["carrier"]
                        label.result = error.message


                        label.save!
                  end
               end
            end
          end




          unless request_labels.finished?
            request_labels.status = "error"
            request_labels.result = "Labels were generated with error"
            count = request_labels.try_count||=0
            request_labels.try_count = count + 1
            request_labels.save

             return false
          else
            request_labels.result = "Successful label generation -> Label compression begin"
            request_labels.save

            tmp_folder = "#{Rails.root.to_s}/tmp/request-#{request_labels.id}"

            zip_file = "#{Rails.root.to_s}/tmp/request-#{request_labels.id}.zip"

            FileUtils.rm_rf(tmp_folder) if File.directory?(tmp_folder)
            FileUtils.rm zip_file if File.exists?(zip_file)


            FileUtils.mkdir_p tmp_folder

            files = []
            request_labels.request_label_details.each do |detail|

                tmp_file = tmp_folder + "/#{detail.shipment_id}.pdf"

                files << {file: tmp_file, name: "#{detail.shipment_id}.pdf" }
                URI.open(tmp_file, 'wb') do |file|
                  file << open(detail.file_url).read
                end



            end

            ::Zip::File.open(zip_file, Zip::File::CREATE) do |zipfile|
              files.each do |file|
               # Add the file to the zip
                zipfile.add(file[:name],  file[:file])
              end
            end
          end

          request_labels.zip.attach(io: File.open(zip_file), filename: "#{request_labels.identifier}.zip")
          request_labels.save

          FileUtils.rm_rf(tmp_folder) if File.directory?(tmp_folder)
          FileUtils.rm zip_file if File.exists?(zip_file)

          request_labels.status = "completed"
          request_labels.result = "Zip file #{request_labels.identifier}.zip generated. "
          request_labels.save

          #rescue => error
           # request_labels.status = "error"
           # request_labels.result = "Label compression has error #{e.messsage}"
            #request_labels.save
          #end


        end

        def initialize(request_labels)
          @request_labels = request_labels
        end
    end
end