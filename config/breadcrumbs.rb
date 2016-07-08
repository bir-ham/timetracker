crumb :root do
  link I18n.t('dashboards.index.header'), root_path
end

crumb :projects do
  link "Projects", projects_path
end

crumb :project do |project|
  link project.name, project_path(project)
  parent :projects
end

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