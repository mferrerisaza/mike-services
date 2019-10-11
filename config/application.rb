require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MikeServices
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework  :test_unit, fixture: false
    end
    config.load_defaults 6.0
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.action_mailer.delivery_method = :mailjet_api
    config.active_job.queue_adapter = :sidekiq
    config.i18n.default_locale = :es
    config.time_zone = 'Bogota'
    config.active_record.default_timezone = :local
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
