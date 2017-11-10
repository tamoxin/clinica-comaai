json.extract! gpost, :id, :title, :body, :link, :gfolder_id, :created_at, :updated_at
json.url gpost_url(gpost, format: :json)
