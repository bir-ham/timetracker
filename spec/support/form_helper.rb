module FormHelper
  # added here cos we'r using this macro in multiple spec files,
  # eventhough it isn't related with the above macro we can still keep it here

  def set_subdomain(subdomain)
    if Capybara.current_driver == :rack_test
      Capybara.app_host = "http://#{subdomain}.example.com"
    else
      Capybara.app_host = "http://#{subdomain}.lvh.me"
      Capybara.server_port = 31234
    end
  end

  def sign_user_in(user, opts={})
    if opts[:subdomain]
      visit new_user_session_url(subdomain: opts[:subdomain])
    else
      visit new_user_session_path
    end
    fill_in 'Email', with: user.email
    fill_in 'Password', with: (opts[:password] || user.password)
    click_button I18n.t('button.sign_in')
  end

  def select_date_and_time(datetime, options = {})
    field = options[:from]
    select datetime.strftime('%Y'), from: "#{field}_1i" #year
    select datetime.strftime('%B'), from: "#{field}_2i" #month
    select datetime.strftime('%1d'), from: "#{field}_3i" #day
    select datetime.strftime('%H'), from: "#{field}_4i" #hour
    select datetime.strftime('%M'), from: "#{field}_5i" #minute
  end

  def select_date(date, options = {})
    field = options[:from]
    select date.strftime('%Y'), from: "#{field}_1i" #year
    select date.strftime('%B'), from: "#{field}_2i" #month
    select date.strftime('%1d'), :from => "#{field}_3i" #day
  end

  def select_generic(field_value, options = {})
    field = options[:from]
    select field_value, from: "#{field}" #field_value
  end

  def submit_form
    find('input[name="commit"]').click
  end

  def submit_form_button
    find('button[type=submit]').click
  end
end