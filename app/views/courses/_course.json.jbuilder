json.extract! course, :id, :code, :name, :description, :professor_id, :active, :created_at, :updated_at
json.url course_url(course, format: :json)
