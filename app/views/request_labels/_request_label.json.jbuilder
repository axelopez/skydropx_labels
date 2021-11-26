json.extract! request_label, :id, :reference, :token_id, :status, :request, :created_at, :updated_at
json.url request_label_url(request_label, format: :json)
