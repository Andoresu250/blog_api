# Rails.application.config.action_controller.forgery_protection_origin_check = true
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :any, expose: %w(Authorization)
  end
end