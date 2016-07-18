class Contact < MailerForm::Base

  validate :name
  validate :email, presence: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create ,message: 'wrong email format' }
  validate :message, presence: true
  validate :nickname, presence: true, captcha: true 

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Contacts mail",
      :to => "birhanu.hailemariam@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end

end
