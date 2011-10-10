require 'rubygems'
require 'action_mailer'
class DumuzziMailer < ActionMailer::Base
    default from: "monitor@dumuzzi.com"

ActionMailer::Base.config.template_root = "#{Dir.pwd}/app/views/dumuzzi_mailer/"
ActionMailer::Base.config.delivery_method = :sendmail
ActionMailer::Base.config.logger = Logger.new(STDOUT)

    def warning_message(warning)
      @warning = warning
      @host = ActionMailer::Base.smtp_settings[:default_url_options]
      mail(
        :to => ActionMailer::Base.smtp_settings[:to],
        :subject => "Host alert!",
	      :message => "Host down!"
	    )
	    puts "[Mailer] Mail sent."
	  end

end
