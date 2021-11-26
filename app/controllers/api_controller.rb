class ApiController < ApplicationController
    before_action :authenticate_user_from_token!, except: [:ping,:request_download]
    skip_before_action  :verify_authenticity_token

    def ping
        render json: { skydropx: "Label Generator", version: "1.0" }
    end

    def request_label



        begin
         body =  JSON.parse(request.body.read.force_encoding('UTF-8'))
        rescue
          render json: {   description: "Invalid JSON"}, status: :bad_request
          return
        end

        request_label = RequestLabel.new
        request_label.token_id = @token.id
        request_label.request = request.body.read.force_encoding('UTF-8')
        request_label.save!

        render json: { request_id: request_label.identifier, details: "" }
    #rescue => e
     #   render json: {  description: "something wrong"}, status: :internal_server_error
    end


    def request_check
       unless params[:request_id].present?
        render json: {   description: "No request identifer"}, status: :bad_request
        return

       end

      if  RequestLabel.where(identifier: params[:request_id]).count == 0
        render json: {   description: "Label  Request not found"}, status: :not_found
        return
      end

      request_label = RequestLabel.where(identifier: params[:request_id]).first
      url=""
      if request_label.status == "completed"
        url= APP_URL+ "/labels/#{request_label.identifier}/download"
      end
      render json: { status: request_label.status, zip_url: url }


    end

    def request_download
      require "open-uri"
      request_label = RequestLabel.where(identifier: params[:id]).first
      send_data URI.open(request_label.zip.service_url) { |f| f.read }, filename: "#{request_label.identifier}.zip", type: :zip
    end

    def authenticate_user_from_token!
        @token = authenticate_with_http_token &method(:authenticator)
    end

    def authenticator(http_token, options)
        resultado = false
        token=http_token


          unless token.present?
            resultado = false
            descripcion = "Invalid Token"
          else

            if Token.where(token: token).count == 0
              resultado = false
              descripcion = "Invalid Token"
            else
               token = Token.where(token: token).first
               resultado = true
               return token
            end
          end
          if !resultado
            render json: { descripcion: descripcion }, status: :unauthorized
            return
          end


    end
end
