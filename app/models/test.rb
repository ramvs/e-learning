class Test < ActiveRecord::Base
  belongs_to :lesson
  has_many :questions, dependent: :destroy
  has_many :test_results
  validates :lesson, presence: true, uniqueness: true

  accepts_nested_attributes_for :questions

end
