class UserAnserw < ActiveRecord::Base
  belongs_to :anserw
  belongs_to :test_result

  validates_presence_of :test_result
  validates_presence_of :anserw

  validates_uniqueness_of :anserw , scope: :test_result
end
