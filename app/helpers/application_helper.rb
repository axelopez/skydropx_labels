module ApplicationHelper
    def formato_fecha_hora(fecha) 
	    if !fecha.nil?
	      fecha.strftime("%m-%d-%Y %H:%M:%S")
	    else
	      ""
	    end
	end
end
