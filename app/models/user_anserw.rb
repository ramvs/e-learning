class UserAnserw < ActiveRecord::Base
  belongs_to :anserw
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :anserw

  validates_uniqueness_of :anserw_id , scope: :user
end
