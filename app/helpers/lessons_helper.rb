module LessonsHelper
	def embed(extern_video_url)
		tag(VideoInfo.new(extern_video_url).embed_code)
  	end
end
