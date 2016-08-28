class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages
  
  validates_presence_of :first_name, :last_name

  # Generate a username for our user based of the first and last name
  before_create :set_username!

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  private
    def set_username!
      self.username = "#{self.first_name}.#{self.last_name}".downcase
    end
end
