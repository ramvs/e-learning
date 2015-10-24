json.array!(@comments) do |comment|
  json.extract! comment, :id, :description, :course_id, :lesson_id, :user_id
  json.url comment_url(comment, format: :json)
end
