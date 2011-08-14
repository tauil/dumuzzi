class DumuzziMailer < ActionMailer::Base
  default from: "from@example.com"

    def warning_message(warning)
      @warning = warning
      @host = ActionMailer::Base.default_url_options[:host]
      mail(
        :to => ActionMailer::Base.smtp_settings[:to],
        :subject => contact.subject,
	      :message => contact.body
	    )
	  end

end
