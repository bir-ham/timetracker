# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Configure javascripts and stylesheets public assets to assets paths 
Rails.application.config.assets.paths << Rails.root.join('public', 'assets', 'javascripts')
Rails.application.config.assets.paths << Rails.root.join('public', 'assets', 'stylesheets')

Rails.application.config.assets.precompile += %w( landing_page.css )
Rails.application.config.assets.precompile += %w( charts.js )
Rails.application.config.assets.precompile += %w( date_time_picker.js )
Rails.application.config.assets.precompile += %w( datatable.js.coffee )
Rails.application.config.assets.precompile += %w( Chart.js )
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
