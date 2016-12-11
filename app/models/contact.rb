class Contact < MailForm::Base
  attr_accessor :name, :email, :message

  validates :name,      presence: true
  validates :email,     presence: true, 
    format: { with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, message: 'wrong email format' }
  validates :message,   presence: true
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "My Contact Form",
      :to => "birhanu.hailemariam@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end

end
