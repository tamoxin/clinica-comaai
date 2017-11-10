json.extract! cpost, :id, :title, :body, :link, :cfolder_id, :created_at, :updated_at
json.url cpost_url(cpost, format: :json)
