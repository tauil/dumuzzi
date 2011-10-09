# Load mail configuration if not in test environment
if Rails.env != 'test'
  email_settings = YAML::load(File.open("#{Rails.root}/config/email.yml"))
  ActionMailer::Base.smtp_settings = email_settings[Rails.env] unless email_settings[Rails.env].nil?
  
  ActionMailer::Base.default_url_options[:host] = ActionMailer::Base.smtp_settings[:default_url_options]
end

