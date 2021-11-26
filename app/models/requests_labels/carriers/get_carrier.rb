module RequestsLabels
    module Carriers
        class GetCarrier
            def self.for(type)
                #Formatter.for(type).format(data)
                case type
                when 'fake_carrier'
                  FakeCarrier
                when 'axel_carrier'
                  AxelCarrier
                else
                  raise 'Unsupported type of carrier'
                end
            end
        end
    end
end