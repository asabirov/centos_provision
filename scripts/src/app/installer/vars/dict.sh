#!/usr/bin/env bash
#





SSL_ENABLER_COMMAND_EN="curl -sSL ${KEITARO_URL}/enable-ssl.sh | bash -s -- domain1.tld [domain2.tld...]"
SSL_ENABLER_COMMAND_RU="curl -sSL ${KEITARO_URL}/enable-ssl.sh | bash -s -- -l ru domain1.tld [domain2.tld...]"

DICT['en.messages.keitaro_already_installed']='Keitaro is already installed'
DICT['en.messages.check_ability_firewall_installing']="Checking the ability of installing a firewall"
DICT['en.messages.check_keitaro_dump_validity']="Checking SQL dump"
DICT['en.messages.enabling_ssl']="Enabling SSL"
DICT["en.messages.successful.rerun_ssl_enabler"]="After troubleshooting, run ssl-enabler again"
DICT['en.messages.successful.use_old_credentials']="The database was successfully restored from the archive. Use old login data"
DICT['en.errors.see_logs']=$(cat <<- END
	Installation log saved to ${SCRIPT_LOG}. Configuration settings saved to ${INVENTORY_FILE}.
	You can rerun \`${SCRIPT_COMMAND}\` with saved settings after resolving installation problems.
END
)
DICT['en.errors.wrong_distro']='This installer works only on CentOS 7.x. Please run this program on clean CentOS server'
DICT['en.errors.cant_install_firewall']='Please run this program in system with firewall support'
DICT['en.errors.cant_create_keitaro_config_dir']="Can not create Keitaro config directory ${CONFIG_DIR}"
DICT['en.errors.keitaro_dump_invalid']='SQL dump is broken'
DICT['en.errors.isp_manager_installed']='You can not install Keitaro on the server with ISP Manager installed. Please run this program on a clean CentOS server.'
DICT['en.errors.vesta_cp_installed']='You can not install Keitaro on the server with Vesta CP installed. Please run this program on a clean CentOS server.'
DICT['en.errors.apache_installed']='You can not install Keitaro on the server with Apache HTTP server installed. Please run this program on a clean CentOS server.'
DICT['en.prompts.skip_firewall']='Do you want to skip installing firewall?'
DICT['en.prompts.skip_firewall.help']=$(cat <<- END
	It looks that your system does not support firewall. This can be happen, for example, if you are using a virtual machine based on OpenVZ and the hosting provider has disabled conntrack support (see http://forum.firstvds.ru/viewtopic.php?f=3&t=10759).
	WARNING: Firewall can help prevent hackers or malicious software from gaining access to your server through Internet. You can continue installing the system without firewall, however we strongly recommend you to run this program on system with firewall support.
END
)
DICT['en.prompts.admin_login']='Please enter Keitaro admin login'
DICT['en.prompts.admin_password']='Please enter Keitaro admin password'
DICT['en.prompts.db_name']='Please enter database name'
DICT['en.prompts.db_password']='Please enter database user password'
DICT['en.prompts.db_user']='Please enter database user name'
DICT['en.prompts.db_restore']='Do you want to restore the database from SQL dump?'
DICT['en.prompts.db_restore_path']='Please enter the path to the SQL dump file'
DICT['en.prompts.db_restore_path_want_exit']='Do you want to exit?'
DICT['en.prompts.db_restore_salt']='Please enter the value of "salt" parameter from the old config (application/config/config.ini.php)'
DICT['en.prompts.license_ip']='Please enter server IP'
DICT['en.prompts.license_key']='Please enter license key'
DICT['en.prompts.ssl']="Do you want to install Free SSL certificates (you can do it later)?"
DICT['en.prompts.ssl_domains']='Please enter server domains, separated by comma without spaces (i.e. domain1.tld,domain2.tld)'
DICT['en.prompts.ssl_email']='Please enter your email (you can left this field empty)'
DICT['en.prompts.ssl_email.help']='You can obtain SSL certificate with no email address. This is strongly discouraged, because in the event of key loss or LetsEncrypt account compromise you will irrevocably lose access to your LetsEncrypt account. You will also be unable to receive notice about impending expiration or revocation of your certificates.'
DICT['en.welcome']=$(cat <<- END
	Welcome to Keitaro installer.
	This installer will guide you through the steps required to install Keitaro on your server.
END
)
DICT['en.prompt_errors.validate_ip']='Please enter valid IPv4 address (ex. 8.8.8.8)'
DICT['en.prompt_errors.validate_license_key']='Please enter valid license key (ex. AAAA-BBBB-CCCC-DDDD)'
DICT['en.prompt_errors.validate_alnumdashdot']='Only Latin letters, numbers, dashes, underscores and dots allowed'
DICT['en.prompt_errors.validate_starts_with_latin_letter']='The value must begin with a Latin letter'
DICT['en.prompt_errors.validate_file_existence']='The file was not found by the specified path, please enter the correct path to the file'
DICT['en.prompt_errors.validate_keitaro_dump']='The SQL dump is broken, please specify path to correct SQL dump of Keitaro'
DICT['en.prompt_errors.validate_not_root']='You are not allowed to use root as database user'
DICT['en.prompt_errors.validate_not_reserved_word']='You are not allowed to use yes/no/true/false for this field'

DICT['ru.messages.keitaro_already_installed']='Keitaro трекер уже установлен.'
DICT['ru.messages.check_ability_firewall_installing']="Проверяем возможность установки фаервола"
DICT['ru.messages.check_keitaro_dump_validity']="Проверяем SQL дамп"
DICT['ru.messages.enabling_ssl']="Подключаем SSL"
DICT["ru.messages.successful.use_old_credentials"]="База данных успешно восстановлена из архива. Используйте старые данные для входа в систему"
DICT["ru.messages.successful.rerun_ssl_enabler"]="После устранения проблем запустите программу выдачи сертификатов заново"
DICT['ru.errors.see_logs']=$(cat <<- END
	Журнал установки сохранён в ${SCRIPT_LOG}. Настройки сохранены в ${INVENTORY_FILE}.
	Вы можете повторно запустить \`${SCRIPT_COMMAND}\` с этими настройками после устранения возникших проблем.
END
)
DICT['ru.errors.wrong_distro']='Установщик Keitaro работает только в CentOS 7.x. Пожалуйста, запустите эту программу в CentOS дистрибутиве'
DICT['ru.errors.cant_create_keitaro_config_dir']="Невозможно создать директорию для конфигурационных файлов Keitaro ${CONFIG_DIR}"
DICT['ru.errors.cant_install_firewall']='Пожалуйста, запустите эту программу на системе с поддержкой фаервола'
DICT['ru.errors.keitaro_dump_invalid']='Указанный файл не является дампом Keitaro или загружен не полностью.'
DICT['ru.errors.isp_manager_installed']="Программа установки не может быть запущена на серверах с установленным ISP Manager. Пожалуйста, запустите эту программу на чистом CentOS сервере."
DICT['ru.errors.vesta_cp_installed']="Программа установки не может быть запущена на серверах с установленной Vesta CP. Пожалуйста, запустите эту программу на чистом CentOS сервере."
DICT['ru.errors.apache_installed']="Программа установки не может быть запущена на серверах с установленным Apache HTTP server. Пожалуйста, запустите эту программу на чистом CentOS сервере."
DICT['ru.prompts.skip_firewall']='Продолжить установку системы без фаервола?'
DICT['ru.prompts.skip_firewall.help']=$(cat <<- END
	Похоже, что на этот сервер невозможно установить фаервол. Такое может произойти, например если вы используете виртуальную машину на базе OpenVZ и хостинг провайдер отключил поддержку модуля conntrack (см. http://forum.firstvds.ru/viewtopic.php?f=3&t=10759).
	ПРЕДУПРЕЖДЕНИЕ. Фаервол может помочь предотвратить доступ хакеров или вредоносного программного обеспечения к вашему серверу через Интернет. Вы можете продолжить установку системы без фаерфола, однако мы настоятельно рекомендуем поменять тарифный план либо провайдера и возобновить установку на системе с поддержкой фаервола.
END
)
DICT['ru.prompts.admin_login']='Укажите имя администратора Keitaro'
DICT['ru.prompts.admin_password']='Укажите пароль администратора Keitaro'
DICT['ru.prompts.db_name']='Укажите имя базы данных'
DICT['ru.prompts.db_password']='Укажите пароль пользователя базы данных'
DICT['ru.prompts.db_user']='Укажите пользователя базы данных'
DICT['ru.prompts.db_restore']='Хотите восстановить базу данных из SQL дампа?'
DICT['ru.prompts.db_restore_path']='Укажите путь к файлу c SQL дампом'
DICT['ru.prompts.db_restore_path_want_exit']='Хотите выйти из программы?'
DICT['ru.prompts.db_restore_salt']='Укажите значение параметра salt из старой конфигурации (application/config/config.ini.php)'
DICT['ru.prompts.license_ip']='Укажите IP адрес сервера'
DICT['ru.prompts.license_key']='Укажите лицензионный ключ'
DICT['ru.prompts.ssl']="Установить бесплатные SSL сертификаты (можно сделать это позже)?"
DICT['ru.prompts.ssl_domains']='Укажите список доменов через запятую без пробелов (например domain1.tld,domain2.tld)'
DICT['ru.prompts.ssl_email']='Укажите email (можно не указывать)'
DICT['ru.prompts.ssl_email.help']='Вы можете получить SSL сертификат без указания email адреса. Однако LetsEncrypt настоятельно рекомендует указать его, так как в случае потери ключа или компрометации LetsEncrypt аккаунта вы полностью потеряете доступ к своему LetsEncrypt аккаунту. Без email вы также не сможете получить уведомление о предстоящем истечении срока действия или отзыве сертификата'
DICT['ru.welcome']=$(cat <<- END
	Добро пожаловать в программу установки Keitaro.
	Эта программа поможет собрать информацию необходимую для установки Keitaro на вашем сервере.
END
)
DICT['ru.prompt_errors.validate_ip']='Введите корректный IPv4 адрес (например 8.8.8.8)'
DICT['ru.prompt_errors.validate_license_key']='Введите корректный ключ лицензии (например AAAA-BBBB-CCCC-DDDD)'
DICT['ru.prompt_errors.validate_alnumdashdot']='Можно использовать только латинские бувы, цифры, тире, подчёркивание и точку'
DICT['ru.prompt_errors.validate_starts_with_latin_letter']='Значение должно начинаться с латинской буквы'
DICT['ru.prompt_errors.validate_file_existence']='Файл по заданному пути не обнаружен, введите правильный путь к файлу'
DICT['ru.prompt_errors.validate_keitaro_dump']='Указанный файл не является дампом Keitaro или загружен не полностью. Укажите путь до корректного SQL дампа'
DICT['ru.prompt_errors.validate_not_root']="Запрещено использовать root в качестве пользователя базы данных"
DICT['ru.prompt_errors.validate_not_reserved_word']='Запрещено использовать yes/no/true/false для этого поля'

COMMENT_ME_IF_POWSCRIPT_WANNT_COMPILE_PROJECT="'"
