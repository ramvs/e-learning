class User < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  has_many :comments
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :rooms, :join_table => "rooms_users", :class_name => "Room"

  def displayName
    email
  end
end
