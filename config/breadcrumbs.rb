crumb :root do
  link I18n.t('dashboards.index.header'), root_path
end

# account
crumb :show_account do |account|
  link account.subdomain, account_path(account)
end

# user
crumb :users do
  link I18n.t('users.index.header'), users_path
end

# project
crumb :projects do
  link I18n.t('projects.index.header'), projects_path
end

crumb :show_project do |project|
  link I18n.t('projects.show.header'), project_path(project)
  parent :projects
end

crumb :edit_project do |project|
  link I18n.t('projects.edit.header'), project_path(project)
  parent :projects
end

crumb :new_project do |project|
  link I18n.t('projects.new.header'), new_project_path
  parent :projects
end

# invoice
crumb :invoices do
  link "Invoices", invoices_path
end

crumb :show_invoice do |invoice|
  link I18n.t('invoices.show.header'), invoice_path(invoice)
  parent :invoices
end

crumb :edit_invoice do |invoice|
  link I18n.t('invoices.edit.header'), invoice_path(invoice)
  parent :invoices
end

crumb :new_invoice do |invoice|
  link I18n.t('invoices.new.header'), new_invoice_path
  parent :invoices
end

# customer
crumb :customers do
  link "customers", customers_path
end

crumb :show_customer do |customer|
  link I18n.t('customers.show.header'), customer_path(customer)
  parent :customers
end

crumb :edit_customer do |customer|
  link I18n.t('customers.edit.header'), customer_path(customer)
  parent :invoices
end

crumb :new_customer do |customer|
  link I18n.t('customers.new.header'), new_customer_path
  parent :customers
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).