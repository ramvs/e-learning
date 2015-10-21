require 'uri'
class Lesson < ActiveRecord::Base
	include ActiveModel::Validations
	belongs_to :course
	has_one :test , dependent: :destroy
	has_many :documents, dependent: :destroy
	validates :course , presence: true
	validate :check_extern_video_presence
	def courseTitle
		course.title
	end
	#Metoda walidujaca adres filmu wideo z zewnetrznego serwisu.
	def check_extern_video_presence
		#Jezeli w formularzu wprowadzono jakies dane
		if self.extern_video_url != ""
			# Jezeli dane zaczynaja sie od http lub https
			if self.extern_video_url =~ URI::regexp(%w(http https))
				#Jezeli link nalezy do jednego z providerow (tzw jego host np. www.vimeo.com)
				if ["www.youtube.com","vimeo.com","www.dailymotion.com"].include? URI(self.extern_video_url).host
					#Za pomoca VideoInfo sprawdz czy film jest dostepny
					begin
					video = VideoInfo.new(self.extern_video_url)
					unless video.available?
						self.errors.add(:extern_video_url, "Video is not avialable.")
					end	
					rescue Exception => e
					self.errors.add(:extern_video_url, "Check your video url once again.")	
					end
	    		else 
				self.errors.add(:extern_video_url, "Entered addres is not belong to provider (e.g Youtube)")
				end
			else
			self.errors.add(:extern_video_url, "Entered addres is not a valid HTTP link")
			end
		end
	end
end
