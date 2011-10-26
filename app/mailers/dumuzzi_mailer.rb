class DumuzziMailer < ActionMailer::Base
  default from: "monitor@dumuzzi.com"

  def warning_message(warning)
    @warning = warning
    @host = ActionMailer::Base.smtp_settings[:default_url_options]
    mail(
#      :to => ActionMailer::Base.smtp_settings[:to],
      :to => warning.host.user.email,
      :subject => "Host alert!",
      :message => "Host down!"
	  )
	  puts "[Mailer] Mail sent."
  end

end
