module MessagesHelper
  
  def recipients_options(chosen_recipient = nil)
    s = ''
    User.all.each do |user|
      avatar = user[:avatar] ? user.avatar.small : '/assets/avatar-placeholder-small'
      s << "<option value='#{user.id}' data-img-src='#{avatar}' #{'selected' if user == chosen_recipient }>#{user.first_name}</option>"
    end
    s.html_safe  
  end
end