#!/usr/bin/env bash

assert_keitaro_not_installed(){
  debug 'Ensure keitaro is not installed yet'
  if is_file_exist ${WEBROOT_PATH}/var/install.lock no; then
    debug 'NOK: keitaro is already installed'
    print_err "$(translate messages.keitaro_already_installed)" 'yellow'
    show_credentials
    clean_up
    exit ${KEITARO_ALREADY_INSTALLED_RESULT}
  else
    debug 'OK: keitaro is not installed yet'
  fi
}
