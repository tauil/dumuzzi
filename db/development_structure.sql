CREATE TABLE `authentications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_authentications_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `domains` (
  `id` varchar(255) NOT NULL,
  `category` int(11) NOT NULL DEFAULT '0',
  `user_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `description` text,
  `allow_comments` tinyint(1) DEFAULT '0',
  `send_alert` tinyint(1) DEFAULT '0',
  `share` tinyint(1) DEFAULT '0',
  `status_id` int(11) NOT NULL DEFAULT '-1',
  `monitor` tinyint(1) DEFAULT '0',
  `enabled` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_domains_on_name` (`name`),
  KEY `index_domains_on_category` (`category`),
  KEY `index_domains_on_user_id` (`user_id`),
  KEY `index_domains_on_address` (`address`),
  KEY `index_domains_on_allow_comments` (`allow_comments`),
  KEY `index_domains_on_send_alert` (`send_alert`),
  KEY `index_domains_on_share` (`share`),
  KEY `index_domains_on_status` (`status_id`),
  KEY `index_domains_on_monitor` (`monitor`),
  KEY `index_domains_on_enabled` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `hosts` (
  `id` varchar(255) NOT NULL,
  `category` int(11) NOT NULL DEFAULT '0',
  `user_id` varchar(255) NOT NULL,
  `domain_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `description` text,
  `tester` tinyint(1) DEFAULT '0',
  `allow_comments` tinyint(1) DEFAULT '0',
  `send_alert` tinyint(1) DEFAULT '0',
  `share` tinyint(1) DEFAULT '0',
  `status_id` int(11) DEFAULT '-1',
  `monitor` tinyint(1) DEFAULT '0',
  `enabled` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `gateway` varchar(255) DEFAULT NULL,
  `gateway_state` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_hosts_on_category` (`category`),
  KEY `index_hosts_on_name` (`name`),
  KEY `index_hosts_on_user_id` (`user_id`),
  KEY `index_hosts_on_domain_id` (`domain_id`),
  KEY `index_hosts_on_address` (`address`),
  KEY `index_hosts_on_allow_comments` (`allow_comments`),
  KEY `index_hosts_on_send_alert` (`send_alert`),
  KEY `index_hosts_on_share` (`share`),
  KEY `index_hosts_on_status` (`status_id`),
  KEY `index_hosts_on_monitor` (`monitor`),
  KEY `index_hosts_on_enabled` (`enabled`),
  KEY `index_hosts_on_gateway` (`gateway`),
  KEY `index_hosts_on_gateway_state` (`gateway_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `hosts_services` (
  `id` varchar(255) NOT NULL,
  `host_id` varchar(255) NOT NULL,
  `service_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `interval_id` int(11) DEFAULT '0',
  `description` text,
  `status_id` int(11) DEFAULT '-1',
  `monitor` tinyint(1) DEFAULT '0',
  `enabled` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_hosts_services_on_host_id` (`host_id`),
  KEY `index_hosts_services_on_service_id` (`service_id`),
  KEY `index_hosts_services_on_user_id` (`user_id`),
  KEY `index_hosts_services_on_interval_id` (`interval_id`),
  KEY `index_hosts_services_on_status` (`status_id`),
  KEY `index_hosts_services_on_monitor` (`monitor`),
  KEY `index_hosts_services_on_enabled` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `intervals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `value` int(11) DEFAULT '0',
  `public` tinyint(1) DEFAULT '0',
  `enabled` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `protocols` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `enabled` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `queueds` (
  `id` varchar(255) NOT NULL,
  `host_id` varchar(255) NOT NULL,
  `service_id` varchar(255) NOT NULL,
  `hosts_service_id` varchar(255) NOT NULL,
  `interval_id` varchar(255) NOT NULL,
  `tester_id` varchar(255) NOT NULL,
  `task_id` varchar(255) NOT NULL,
  `status_id` int(11) DEFAULT '-1',
  `done` tinyint(1) DEFAULT '0',
  `run_at` datetime NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `index_queueds_on_host_id` (`host_id`),
  KEY `index_queueds_on_service_id` (`service_id`),
  KEY `index_queueds_on_interval_id` (`interval_id`),
  KEY `index_queueds_on_tester_id` (`tester_id`),
  KEY `index_queueds_on_task_id` (`task_id`),
  KEY `index_queueds_on_status` (`status_id`),
  KEY `index_queueds_on_done` (`done`),
  KEY `index_queueds_on_run_at` (`run_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `services` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `protocol_id` varchar(255) NOT NULL,
  `port` int(11) NOT NULL,
  `description` text,
  `plugin` varchar(255) DEFAULT NULL,
  `monitor` tinyint(1) DEFAULT '0',
  `enabled` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_services_on_name` (`name`),
  KEY `index_services_on_protocol_id` (`protocol_id`),
  KEY `index_services_on_port` (`port`),
  KEY `index_services_on_monitor` (`monitor`),
  KEY `index_services_on_enabled` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `status_changes` (
  `id` varchar(255) NOT NULL,
  `hosts_service_id` varchar(255) NOT NULL,
  `tester_id` varchar(255) NOT NULL,
  `service_id` varchar(255) NOT NULL,
  `interval_id` varchar(255) NOT NULL,
  `from_status_id` int(11) NOT NULL,
  `to_status_id` int(11) NOT NULL,
  `description` text,
  `status_id` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `host_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_state_changes_on_host_id` (`hosts_service_id`),
  KEY `index_state_changes_on_tester_id` (`tester_id`),
  KEY `index_state_changes_on_service_id` (`service_id`),
  KEY `index_state_changes_on_interval_id` (`interval_id`),
  KEY `index_state_changes_on_from_status` (`from_status_id`),
  KEY `index_state_changes_on_to_status` (`to_status_id`),
  KEY `index_state_changes_on_status` (`status_id`),
  KEY `index_status_changes_on_host_id` (`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `statuses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `action` varchar(255) NOT NULL,
  `enabled` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_statuses_on_id` (`id`),
  KEY `index_statuses_on_name` (`name`),
  KEY `index_statuses_on_action` (`action`),
  KEY `index_statuses_on_enabled` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20110813013100');

INSERT INTO schema_migrations (version) VALUES ('20110813032217');

INSERT INTO schema_migrations (version) VALUES ('20110814111623');

INSERT INTO schema_migrations (version) VALUES ('20110814120112');

INSERT INTO schema_migrations (version) VALUES ('20110814120736');

INSERT INTO schema_migrations (version) VALUES ('20110814121404');

INSERT INTO schema_migrations (version) VALUES ('20110814123655');

INSERT INTO schema_migrations (version) VALUES ('20110814130952');

INSERT INTO schema_migrations (version) VALUES ('20110814131544');

INSERT INTO schema_migrations (version) VALUES ('20110814201552');

INSERT INTO schema_migrations (version) VALUES ('20110814203613');

INSERT INTO schema_migrations (version) VALUES ('20111008154219');

INSERT INTO schema_migrations (version) VALUES ('20111009024428');

INSERT INTO schema_migrations (version) VALUES ('20111009061700');

INSERT INTO schema_migrations (version) VALUES ('20111009180624');

INSERT INTO schema_migrations (version) VALUES ('20111009194441');

INSERT INTO schema_migrations (version) VALUES ('20111010032710');

INSERT INTO schema_migrations (version) VALUES ('20111010051906');

INSERT INTO schema_migrations (version) VALUES ('20111011004017');

INSERT INTO schema_migrations (version) VALUES ('20111015032646');