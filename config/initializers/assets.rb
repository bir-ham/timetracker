# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( landing_page.scss )
Rails.application.config.assets.precompile += %w( charts.js.coffee )
Rails.application.config.assets.precompile += %w( date_time_picker.js )
Rails.application.config.assets.precompile += %w( datatable.js.coffee )
Rails.application.config.assets.precompile += %w( Chart.js )
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
