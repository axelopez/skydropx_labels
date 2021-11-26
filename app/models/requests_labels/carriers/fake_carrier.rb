module RequestsLabels
    module Carriers
        class FakeCarrier
            def self.label(json)
                
                url = URI("https://fake-carrier-api.skydropx.com/v1/labels")

                https = Net::HTTP.new(url.host, url.port)
                https.use_ssl = true

                request = Net::HTTP::Post.new(url)
                request["Authorization"] = "Bearer vgEOaYn0LItk5K9FBEP9j9EUjZwcZvvL"
                request["Content-Type"] = "application/json"
                request.body = JSON.dump( json)

                response = https.request(request)

                respuesta = JSON.parse(response.body)                

                if (response.code=="200")                    

                    return {result: true, data: { 
                                shipment_id: respuesta["data"]["attributes"]["shipment_id"] ,
                                tracking_number: respuesta["data"]["attributes"]["tracking_number"] ,
                                file_url: respuesta["data"]["attributes"]["file_url"] 
                            }

                                                    
                    }
                else
                    return {result: false, error: respuesta["error"]}
                end

            end
        end
    end
end