require File.expand_path('../boot', __FILE__)

require 'rails/all'
# Added for postgis adapter:
require 'active_record/connection_adapters/postgis_adapter'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module KgGallery
  class Application < Rails::Application
    
    config.main_title = "KgGallery"
    
    config.log_level = :info
    
    gallery_shortname = File.open(Rails.root.to_s+"/config/gallery_shortname.txt").first.sub("\n", "")
    config.gallery_shortname = gallery_shortname
    gallery_config_path = Rails.root.to_s+"/config/gallery_configs/#{gallery_shortname}"
    config.gallery_config_path = gallery_config_path
    config.assets.precompile += %w( *.css *.js )
    config.assets.paths << "#{Rails.root}/files"
    #config.active_record.schema_format = :sql
    
    # Include model/view/controller subfolders:
    config.autoload_paths += Dir[
      "#{Rails.root.to_s}/app/models/**/",
      "#{gallery_config_path}/models/**/",
      "#{Rails.root.to_s}/app/controllers/**/",
      "#{gallery_config_path}/controllers/**/",
      "#{Rails.root.to_s}/app/views/**/",
      "#{gallery_config_path}/views/**/"
    ]
    config.paths['app/views'].unshift("config/gallery_configs/#{gallery_shortname}/views")
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :fr
    config.i18n.fallbacks = [:fr]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**/', '*.{rb,yml}'), Rails.root.join('config', 'gallery_configs', gallery_shortname, 'locales', '*.{rb,yml}')]
    config.enabled_languages = { :fr => 'fr' } # :lang => 'flag_name'
    config.i18n.available_locales = [:fr]
    config.time_zone = 'Eastern Time (US & Canada)'
    config.default_timezone_shortname = "America/Montreal"
    config.active_record.default_timezone = :local
    config.holidays_region = :ca
    config.holidays_subregion = :ca_qc
    config.projected_geometry_srid = 32188
    
    # Load custom configuration fromt external rb file:
    eval(File.open("#{gallery_config_path}/application.rb").read) if File.exists?("#{gallery_config_path}/application.rb")
    
    #config.paperclip_defaults = {:storage => :file}
    
    
  end
end
