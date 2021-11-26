module RequestsLabels
    module Carriers
        class AxelCarrier
            def self.label(json)
                files = []
                files << "#{url}/pdf/1.pdf"
                files << "#{url}/pdf/2.pdf"
                files << "#{url}/pdf/3.pdf"
                files << "#{url}/pdf/4.pdf"

                file = files.sample

                return {result: true, data: {
                    shipment_id: Time.now.to_i - rand(100000),
                    tracking_number:   9999999999-Time.now.to_i - rand(100000),
                    file_url: file
                        }
                    }


            end
        end
    end
end