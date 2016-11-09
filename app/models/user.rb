class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  acts_as_messageable
  
  has_many :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.invited_users
    invited_users = User.where.not(invited_by_id: nil)
  end
end
