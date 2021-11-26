module RequestsLabels
    module Carriers
        class Carrier
            def self.get_label(json)
                GetCarrier.for(json["carrier"]).label(json)                
            end
        end
    end
end