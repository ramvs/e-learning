class Test < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :lesson
  has_many :questions, dependent: :destroy
  has_many :test_results
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
  validates :lesson, presence: true, uniqueness: true

  accepts_nested_attributes_for :questions

end
