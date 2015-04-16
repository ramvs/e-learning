class Test < ActiveRecord::Base
	belongs_to :lesson
	has_many :questions
	validates :lesson , presence: true , uniqueness: true

	accepts_nested_attributes_for :questions

	def compute_score arr
		points = 0
		return 0 if arr == nil
		max = questions.count
		questions.all.each do |q|
			
			current = arr[q.id.to_s]
			
			if current==nil
				next
			end

			correct = q.anserws.where(correct: true).pluck(:id)

			if correct.length != current.length 
				next
			end

			error = false
			correct.each do |a|
				if current.find_index(a.to_s)==nil
					error =true
					break
				end
			end
			if error==false
				points=points+1
			end
		end
		points
	end
end
