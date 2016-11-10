module MessagesHelper
  
  def recipients_options
    s = ''
    User.all.each do |user|
      s << "<option value='#{user.id}'>#{user.first_name}</option>"
  end
end