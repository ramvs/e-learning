class Room < ActiveRecord::Base
  include PublicActivity::Model

  has_and_belongs_to_many :users, :join_table => "rooms_users", :class_name => "User"
  validates :name, uniqueness: true
end
