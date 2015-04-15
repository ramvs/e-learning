class Room < ActiveRecord::Base
  validates :name, uniqueness: true
end
