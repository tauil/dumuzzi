tester_yml = YAML::load(File.open("#{Rails.root}/config/tester.yml"))
Rails.application.config.local_tester = tester_yml[Rails.env] unless tester_yml[Rails.env].nil?

