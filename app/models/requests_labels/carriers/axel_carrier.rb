module RequestsLabels
    module Carriers
        class AxelCarrier
            def self.label(json)
                files = []
                files << "#{APP_URL}/pdf/1.pdf"
                files << "#{APP_URL}/pdf/2.pdf"
                files << "#{APP_URL}/pdf/3.pdf"
                files << "#{APP_URL}/pdf/4.pdf"

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