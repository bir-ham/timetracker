class Contact < ActiveRecord::Base

  validate :name, presence: true
  validate :email, presence: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create ,message: 'wrong email format' }
  validate :message, presence: true
  validate :nickname, presence: true
end
