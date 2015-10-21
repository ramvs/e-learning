class Document < ActiveRecord::Base
	belongs_to :lesson
	has_attached_file :attached_doc, :url  => "/assets/publications/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/publications/:id/:style/:basename.:extension"
    validates_attachment_content_type :attached_doc, :with => %r{\.(docx|doc|pdf|mp4)$}i ,
      :content_type => [ "application/pdf","application/vnd.ms-excel",     
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
             "application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
             "text/plain","video/mp4" ]
    validates :title , presence: true
end
