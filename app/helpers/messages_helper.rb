module MessagesHelper
  
  def recipients_options
    avatar = if participant[:avatar] ? participant.avatar.small : 'avatar-placeholder-small'
      
    s = ''
    User.all.each do |user|
      s << "<option value='#{user.id}' data-img-src='#{avatar}'>#{user.first_name}</option>"
    end
    s.html_safe  
  end
end