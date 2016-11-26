class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, 
      :validatable, :confirmable, :registerable
  
  acts_as_messageable

  before_save :set_admin
  
  has_many :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true

  mount_uploader :avatar, Uploader

  def self.invited_users
    invited_users = User.where.not(invited_by_id: nil)
  end

  def mailboxer_email(object)
    email  
  end

  private
  def set_admin
    self.admin = User.count == 0  
  end

end
