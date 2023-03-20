HealthCheck.setup do |config|

  # uri prefix (no leading slash)
  config.uri = 'health_check'

  # Text output upon success
  config.success = 'success'

  config.http_status_for_error_text = 500

  config.http_status_for_error_object = 500

  # You can customize which checks happen on a standard health check, eg to set an explicit list use:
  # config.standard_checks = %w[database migrations cache]
  config.standard_checks = %w[cache]

  # You can set what tests are run with the 'full' or 'all' parameter
  # config.full_checks = %w[database migrations cache]
  config.full_checks = %w[cache]
end