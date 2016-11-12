module MessagesHelper
  
  def recipients_options(chose_recipient = nil)
    avatar = participant[:avatar] ? participant.avatar.small : 'avatar-placeholder-small'
      
    s = ''
    User.all.each do |user|
      s << "<option value='#{user.id}' data-img-src='#{avatar} #{'selected' if user == chose_recipient }>#{user.first_name}</option>"
    end
    s.html_safe  
  end
end