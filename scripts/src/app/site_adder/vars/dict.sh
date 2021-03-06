#!/usr/bin/env bash
DICT['en.errors.see_logs']="Evaluating log saved to ${SCRIPT_LOG}. Please rerun \`${SCRIPT_COMMAND}\` after resolving problems."
DICT['en.errors.reinstall_keitaro']="Your Keitaro installation does not properly configured. Please reconfigure Keitaro by evaluating command \`${RECONFIGURE_KEITARO_COMMAND_EN}\`"
DICT['en.errors.vhost_already_exists']="Can not save site configuration - :vhost_filepath: already exists"
DICT['en.errors.site_root_not_exists']="Can not save site configuration - :site_root: directory does not exist"
DICT['en.messages.add_vhost']="Creating site config"
DICT['en.prompts.site_domains']='Please enter domain name with aliases, separated by comma without spaces (i.e. domain1.tld,www.domain1.tld)'
DICT['en.prompts.site_root']='Please enter site root directory'

DICT['ru.errors.reinstall_keitaro']="Keitaro отконфигурирована неправильно. Пожалуйста выполните перенастройку Keitaro выполнив команду \`${RECONFIGURE_KEITARO_COMMAND_RU}\`"
DICT['ru.errors.see_logs']="Журнал выполнения сохранён в ${SCRIPT_LOG}. Пожалуйста запустите \`${SCRIPT_COMMAND}\` после устранения возникших проблем."
DICT['ru.errors.vhost_already_exists']="Невозможно сохранить конфигурацию сайта - :vhost_filepath: уже существует"
DICT['ru.errors.site_root_not_exists']="Невозможно сохранить конфигурацию сайта - нет директории :site_root:"
DICT['ru.messages.add_vhost']="Создаётся конфигурация для сайта"
DICT['ru.prompts.site_domains']='Укажите доменное имя и список альясов через запятую без пробелов (например domain1.tld,www.domain1.tld)'
DICT['ru.prompts.site_root']='Укажите корневую директорию сайта'
