#!/usr/bin/env bash

# Generated by POWSCRIPT (https://github.com/coderofsalvation/powscript)

# Unless you like pain: edit the .pow sourcefiles instead of this file

# powscript general settings
set -e                                # halt on error
set +m                                
SHELL="$(echo $0)"                    # shellname
shopt -s lastpipe                     # flexible while loops (maintain scope)
shopt -s extglob                      # regular expressions
path="$(pwd)"
if [[ "$BASH_SOURCE" == "$0"  ]];then 
  SHELLNAME="$(basename $SHELL)"      # shellname without path
  selfpath="$( dirname "$(readlink -f "$0")" )"
  tmpfile="/tmp/$(basename $0).tmp.$(whoami)"
else
  selfpath="$path"
  tmpfile="/tmp/.dot.tmp.$(whoami)"
fi





empty()
{
    [[ "${#1}" == 0 ]] && return 0 || return 1
}

isset ()
{
    [[ ! "${#1}" == 0 ]] && return 0 || return 1
}

on ()
{
    func="$1";
    shift;
    for sig in "$@";
    do
        trap "$func $sig" "$sig";
    done
}

values ()
{
    echo "$2"
}

last ()
{
    [[ ! -n $1 ]] && return 1;
    echo "$(eval "echo \${$1[@]:(-1)}")"
}




TOOL_NAME='enable-ssl'


#




SHELL_NAME=$(basename "$0")

SUCCESS_RESULT=0
TRUE=0
FAILURE_RESULT=1
FALSE=1
ROOT_UID=0

KEITARO_URL="https://keitaro.io"

RELEASE_VERSION="1.0"
DEFAULT_RELEASE_BRANCH="release-${RELEASE_VERSION}"
RELEASE_BRANCH="${RELEASE_BRANCH:-${DEFAULT_RELEASE_BRANCH}}"

WEBROOT_PATH="/var/www/keitaro"

CONFIG_DIR=".keitaro"
INVENTORY_FILE="${CONFIG_DIR}/installer_config"

NGINX_ROOT_PATH="/etc/nginx"
NGINX_VHOSTS_DIR="${NGINX_ROOT_PATH}/conf.d"
NGINX_KEITARO_CONF="${NGINX_VHOSTS_DIR}/keitaro.conf"

SCRIPT_NAME="${TOOL_NAME}.sh"
SCRIPT_URL="${KEITARO_URL}/${TOOL_NAME}.sh"
SCRIPT_LOG="${TOOL_NAME}.log"

CURRENT_COMMAND_OUTPUT_LOG="current_command.output.log"
CURRENT_COMMAND_ERROR_LOG="current_command.error.log"
CURRENT_COMMAND_SCRIPT_NAME="current_command.sh"

INDENTATION_LENGTH=2
INDENTATION_SPACES=$(printf "%${INDENTATION_LENGTH}s")

if ! empty ${@}; then
  SCRIPT_COMMAND="curl -sSL "$SCRIPT_URL" > run; bash run ${@}"
  TOOL_ARGS="${@}"
else
  SCRIPT_COMMAND="curl -sSL "$SCRIPT_URL" > run; bash run"
fi

declare -A VARS

RECONFIGURE_KEITARO_COMMAND_EN="curl -sSL ${KEITARO_URL}/install.sh > run; bash run"
RECONFIGURE_KEITARO_COMMAND_RU="curl -sSL ${KEITARO_URL}/install.sh > run; bash run -l ru"

SSL_ENABLER_ERRORS_LOG="${CONFIG_DIR}/ssl_enabler_errors.log"


declare -A DICT

DICT['en.errors.program_failed']='PROGRAM FAILED'
DICT['en.errors.must_be_root']='You must run this program as root.'
DICT['en.errors.reconfigure_keitaro']=$(cat <<-END
	Please run following command

	:obsolete_tool_command:
END
)

DICT['en.errors.run_command.fail']='There was an error evaluating current command'
DICT['en.errors.run_command.fail_extra']=''
DICT['en.errors.terminated']='Terminated by user'
DICT['en.messages.reload_nginx']="Reloading nginx"
DICT['en.messages.run_command']='Evaluating command'
DICT['en.messages.successful']='Everything is done!'
DICT['en.no']='no'
DICT['en.prompt_errors.validate_domains_list']='Please enter domains list, separated by comma without spaces (i.e. domain1.tld,www.domain1.tld). Each domain name must consist of only letters, numbers and hyphens and contain at least one dot.'
DICT['en.prompt_errors.validate_presence']='Please enter value'
DICT['en.prompt_errors.validate_yes_no']='Please answer "yes" or "no"'

DICT['ru.errors.program_failed']='ОШИБКА ВЫПОЛНЕНИЯ ПРОГРАММЫ'
DICT['ru.errors.must_be_root']='Эту программу может запускать только root.'
DICT['ru.errors.reconfigure_keitaro']=$(cat <<- END
	Запустите пожалуйста команду

	:obsolete_tool_command:
END
)
DICT['ru.errors.run_command.fail']='Ошибка выполнения текущей команды'
DICT['ru.errors.run_command.fail_extra']=''
DICT['ru.errors.terminated']='Выполнение прервано'
DICT['ru.messages.reload_nginx']="Перезагружается nginx"
DICT['ru.messages.run_command']='Выполняется команда'
DICT['ru.messages.successful']='Готово!'
DICT['ru.no']='нет'
DICT['ru.prompt_errors.validate_domains_list']='Укажите список доменных имён через запятую без пробелов (например domain1.tld,www.domain1.tld). Каждое доменное имя должно состоять только из букв, цифр и тире и содержать хотябы одну точку.'
DICT['ru.prompt_errors.validate_presence']='Введите значение'
DICT['ru.prompt_errors.validate_yes_no']='Ответьте "да" или "нет" (можно также ответить "yes" или "no")'



declare -a DOMAINS
declare -a SUCCESSFUL_DOMAINS
declare -a FAILED_DOMAINS
SSL_ROOT="/etc/keitaro/ssl"
SSL_CERT_PATH="${SSL_ROOT}/cert.pem"
SSL_PRIVKEY_PATH="${SSL_ROOT}/privkey.pem"
CERT_DOMAINS_PATH="${CONFIG_DIR}/ssl_enabler_cert_domains"
CERTBOT_LOG="${CONFIG_DIR}/ssl_enabler_cerbot.log"


#




RECONFIGURE_KEITARO_SSL_COMMAND_EN="curl -sSL ${KEITARO_URL}/install.sh | bash -s -- -l en -t nginx,ssl"

RECONFIGURE_KEITARO_SSL_COMMAND_RU="curl -sSL ${KEITARO_URL}/install.sh | bash -s -- -l ru -t nginx,ssl"

DICT['en.errors.reinstall_keitaro']="Your Keitaro installation does not properly configured. Please reconfigure Keitaro by evaluating command \`${RECONFIGURE_KEITARO_COMMAND_EN}\`"
DICT['en.errors.reinstall_keitaro_ssl']="Nginx settings of your Keitaro installation does not properly configured. Please reconfigure Nginx by evaluating command \`${RECONFIGURE_KEITARO_SSL_COMMAND_EN}\`"
DICT['en.errors.see_logs']="Evaluating log saved to ${SCRIPT_LOG}. Please rerun \`${SCRIPT_COMMAND}\` after resolving problems."
DICT['en.errors.domain_invalid']=":domain: doesn't look as valid domain"
DICT['en.certbot_errors.wrong_a_entry']="Please make sure that your domain name was entered correctly and the DNS A record for that domain contains the right IP address. You need to wait a little if the DNS A record was updated recently."
DICT['en.certbot_errors.too_many_requests']="There were too many requests. See https://letsencrypt.org/docs/rate-limits/."
DICT['en.certbot_errors.unknown_error']="There was unknown error while issuing certificate, please contact support team"
DICT['en.messages.check_renewal_job_scheduled']="Check that the renewal job is scheduled"
DICT['en.messages.make_ssl_cert_links']="Make SSL certificate links"
DICT['en.messages.requesting_certificate_for']="Requesting certificate for"
DICT['en.messages.generating_nginx_config_for']="Generating nginx config for"
DICT['en.messages.schedule_renewal_job']="Schedule renewal SSL certificate cron job"
DICT['en.messages.ssl_enabled_for_domains']="SSL certificates are issued for domains:"
DICT['en.messages.ssl_not_enabled_for_domains']="There were errors while issuing certificates for domains:"
DICT['en.warnings.nginx_config_exists_for_domain']="nginx config already exists"
DICT['en.warnings.certificate_exists_for_domain']="certificate already exists"
DICT['en.warnings.skip_nginx_config_generation']="skipping nginx config generation"
DICT['en.prompts.ssl_agree_tos']="Do you agree with terms of Let's Encrypt Subscriber Agreement?"
DICT['en.prompts.ssl_agree_tos.help']=$(cat <<- END
	Make sure all the domains are already linked to this server in the DNS
	In order to install Let's Encrypt Free SSL certificates for your Keitaro you must agree with terms of Let's Encrypt Subscriber Agreement (https://letsencrypt.org/documents/LE-SA-v1.0.1-July-27-2015.pdf).
END
)
DICT['en.prompts.ssl_email']='Please enter your email (you can left this field empty)'
DICT['en.prompts.ssl_email.help']='You can obtain SSL certificate with no email address. This is strongly discouraged, because in the event of key loss or LetsEncrypt account compromise you will irrevocably lose access to your LetsEncrypt account. You will also be unable to receive notice about impending expiration or revocation of your certificates.'

DICT['ru.errors.reinstall_keitaro']="Keitaro отконфигурирована неправильно. Пожалуйста выполните перенастройку Keitaro выполнив команду \`${RECONFIGURE_KEITARO_COMMAND_RU}\`"
DICT['ru.errors.reinstall_keitaro_ssl']="Настройки Nginx вашей Keitaro отконфигурированы неправильно. Пожалуйста выполните перенастройку Nginx выполнив команду \`${RECONFIGURE_KEITARO_SSL_COMMAND_RU}\`"
DICT['ru.errors.see_logs']="Журнал выполнения сохранён в ${SCRIPT_LOG}. Пожалуйста запустите \`${SCRIPT_COMMAND}\` после устранения возникших проблем."
DICT['ru.errors.domain_invalid']=":domain: не похож на домен"
DICT['ru.certbot_errors.wrong_a_entry']="Убедитесь что домен верный и что DNS A запись указывает на нужный IP адрес. Если A запись была обновлена недавно, то следует подождать некоторое время."
DICT['ru.certbot_errors.too_many_requests']="Было слишком много запросов, см. https://letsencrypt.org/docs/rate-limits/"
DICT['ru.certbot_errors.unknown_error']="Во время выпуска сертификата произошла неизвестная ошибка. Пожалуйста, обратитесь в службу поддержки"
DICT['ru.messages.check_renewal_job_scheduled']="Проверяем наличие cron задачи обновления сертификатов"
DICT['ru.messages.make_ssl_cert_links']="Создаются ссылки на SSL сертификаты"
DICT['ru.messages.requesting_certificate_for']="Запрос сертификата для"
DICT['ru.messages.generating_nginx_config_for']="Генерация конфигурации для"
DICT['ru.messages.schedule_renewal_job']="Добавляется cron задача обновления сертификатов"
DICT['ru.messages.ssl_enabled_for_domains']="SSL сертификаты выпущены для сайтов:"
DICT['ru.messages.ssl_not_enabled_for_domains']="SSL сертификаты не выпущены для сайтов:"
DICT['ru.warnings.nginx_config_exists_for_domain']="nginx конфигурация уже существует"
DICT['ru.warnings.certificate_exists_for_domain']="сертификат уже существует"
DICT['ru.warnings.skip_nginx_config_generation']="пропускаем генерацию конфигурации nginx"
DICT['ru.prompts.ssl_agree_tos']="Вы согласны с условиями Абонентского Соглашения Let's Encrypt?"
DICT['ru.prompts.ssl_agree_tos.help']=$(cat <<- END
	Убедитесь, что все указанные домены привязаны к этому серверу в DNS.
	Для получения бесплатных SSL сертификатов Let's Encrypt вы должны согласиться с условиями Абонентского Соглашения Let's Encrypt (https://letsencrypt.org/documents/LE-SA-v1.0.1-July-27-2015.pdf)."
END
)
DICT['ru.prompts.ssl_email']='Укажите email (можно не указывать)'
DICT['ru.prompts.ssl_email.help']='Вы можете получить SSL сертификат без указания email адреса. Однако LetsEncrypt настоятельно рекомендует указать его, так как в случае потери ключа или компрометации LetsEncrypt аккаунта вы полностью потеряете доступ к своему LetsEncrypt аккаунту. Без email вы также не сможете получить уведомление о предстоящем истечении срока действия или отзыве сертификата'



#





assert_caller_root(){
  debug 'Ensure script has been running by root'
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: actual checking of current user"
  else
    if [[ "$EUID" == "$ROOT_UID" ]]; then
      debug 'OK: current user is root'
    else
      debug 'NOK: current user is not root'
      fail "$(translate errors.must_be_root)"
    fi
  fi
}



assert_installed(){
  local program="${1}"
  local error="${2}"
  if ! is_installed "$program"; then
    fail "$(translate ${error})" "see_logs"
  fi
}


#






assert_server_configuration_relevant(){
  debug 'Ensure configs has been genereated by relevant installer'
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: аctual check of installer version in ${INVENTORY_FILE} disabled"
  else
    installed_version=$(detect_installed_version)
    if [[ "${RELEASE_VERSION}" == "${installed_version}" ]]; then
      debug "Configs has been generated by recent version of installer ${RELEASE_VERSION}"
    else
      fail "$(build_upgrade_message "${installed_version}")"
    fi
  fi
}


detect_installed_version(){
  local version=""
  if is_file_exist ${INVENTORY_FILE}; then
    version=$(grep "^installer_version=" ${INVENTORY_FILE} | sed s/^installer_version=//g)
  fi
  if empty "$version"; then
    version="0.9"
  fi
  echo "$version"
}


build_upgrade_message(){
  local installed_version="${1}"
  translate 'errors.reconfigure_keitaro' "upgrade_command='$(build_upgrade_command)'" \
    "obsolete_tool_command='$(build_obsolete_tool_command "${installed_version}")'"
  }


build_upgrade_command(){
  installer_url="https://keitaro.io/release-${RELEASE_VERSION}/install.sh"
  echo "curl ${installer_url} > run; bash run -rt upgrade,upgrade_to_${RELEASE_VERSION//\./_}"
}


build_obsolete_tool_command(){
  local installed_version="${1}"
  local obsolete_tool_name="release-${installed_version}/${TOOL_NAME}"
  echo "${SCRIPT_COMMAND/${TOOL_NAME}/${obsolete_tool_name}}"
}


#





is_file_exist(){
  local file="${1}"
  local result_on_skip="${2}"
  debug "Checking ${file} file existence"
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: аctual check of ${file} file existence disabled"
    if [[ "$result_on_skip" == "no" ]]; then
      debug "NO: simulate ${file} file does not exist"
      return ${FAILURE_RESULT}
    fi
    debug "YES: simulate ${file} file exists"
    return ${SUCCESS_RESULT}
  fi
  if [ -f "${file}" ]; then
    debug "YES: ${file} file exists"
    return ${SUCCESS_RESULT}
  else
    debug "NO: ${file} file does not exist"
    return ${FAILURE_RESULT}
  fi
}


#





is_directory_exist(){
  local directory="${1}"
  local result_on_skip="${2}"
  debug "Checking ${directory} directory existence"
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: аctual check of ${directory} directory existence disabled"
    if [[ "$result_on_skip" == "no" ]]; then
      debug "NO: simulate ${directory} directory does not exist"
      return ${FAILURE_RESULT}
    fi
    debug "YES: simulate ${directory} directory exists"
    return ${SUCCESS_RESULT}
  fi
  if [ -d "${directory}" ]; then
    debug "YES: ${directory} directory exists"
    return ${SUCCESS_RESULT}
  else
    debug "NO: ${directory} directory does not exist"
    return ${FAILURE_RESULT}
  fi
}


#





set_ui_lang(){
  if empty "$UI_LANG"; then
    UI_LANG=$(detect_language)
  fi
  debug "Language: ${UI_LANG}"
}


detect_language(){
  if ! empty "$LC_ALL"; then
    detect_language_from_var "$LC_ALL"
  else
    if ! empty "$LC_MESSAGES"; then
      detect_language_from_var "$LC_MESSAGES"
    else
      detect_language_from_var "$LANG"
    fi
  fi
}


detect_language_from_var(){
  local lang_value="${1}"
  if [[ "$lang_value" =~ ^ru_[[:alpha:]]+\.UTF-8$ ]]; then
    echo ru
  else
    echo en
  fi
}


#





translate(){
  local key="${1}"
  local i18n_key=$UI_LANG.$key
  message="${DICT[$i18n_key]}"
  while isset "${2}"; do
    message=$(interpolate "${message}" "${2}")
    shift
  done
  echo "$message"
}


interpolate(){
  local string="${1}"
  local substitution="${2}"
  IFS="=" read name value <<< "${substitution}"
  string="${string//:${name}:/${value}}"
  echo "${string}"
}


#





is_installed(){
  local command="${1}"
  debug "Try to found "$command""
  if isset "$SKIP_CHECKS"; then
    debug "SKIPPED: actual checking of '$command' presence skipped"
  else
    if [[ $(sh -c "command -v "$command" -gt /dev/null") ]]; then
      debug "FOUND: "$command" found"
    else
      debug "NOT FOUND: "$command" not found"
      return ${FAILURE_RESULT}
    fi
  fi
}



add_indentation(){
  sed -r "s/^/$INDENTATION_SPACES/g"
}



force_utf8_input(){
  LC_CTYPE=en_US.UTF-8
  if [ -f /proc/$$/fd/1 ]; then
    stty -F /proc/$$/fd/1 iutf8
  fi
}


#






get_user_var(){
  local var_name="${1}"
  local validation_methods="${2}"
  print_prompt_help "$var_name"
  while true; do
    print_prompt "$var_name"
    value="$(read_stdin)"
    debug "$var_name: got value '${value}'"
    if ! empty "$value"; then
      VARS[$var_name]="${value}"
    fi
    error=$(get_error "${var_name}" "$validation_methods")
    if isset "$error"; then
      debug "$var_name: validation error - '${error}'"
      print_prompt_error "$error"
      VARS[$var_name]=''
    else
      if [[ "$validation_methods" =~ 'validate_yes_no' ]]; then
        transform_to_yes_no "$var_name"
      fi
      debug "  ${var_name}=${value}" 'light.blue'
      break
    fi
  done
}


hack_stdin_if_pipe_mode(){
  if is_pipe_mode; then
    debug 'Detected pipe bash mode. Stdin hack enabled'
    hack_stdin
  else
    debug "Can't detect pipe bash mode. Stdin hack disabled"
  fi
}


hack_stdin(){
  exec 3<&1
}



is_pipe_mode(){
  [ "${SHELL_NAME}" == 'bash' ]
}


#





print_prompt(){
  local var_name="${1}"
  prompt=$(translate "prompts.$var_name")
  prompt="$(print_with_color "$prompt" 'bold')"
  if ! empty ${VARS[$var_name]}; then
    prompt="$prompt [${VARS[$var_name]}]"
  fi
  echo -en "$prompt > "
}


print_prompt_error(){
  local error_key="${1}"
  error=$(translate "prompt_errors.$error_key")
  print_with_color "*** ${error}" 'red'
}



print_prompt_help(){
  local var_name="${1}"
  print_translated "prompts.$var_name.help"
}



read_stdin(){
  if is_pipe_mode; then
    read -r -u 3 variable
  else
    read -r variable
  fi
  echo "$variable"
}


#






regenerate_vhost_config(){
  local domain="${1}"
  local message_key="${2}"
  local generating_message="$(translate "${message_key}")"
  local command=""
  local changes=""
  local vhost_path="$(get_vhost_path "$domain")"
  local vhost_backup_path="$(get_vhost_backup_path "$domain")"
  if is_file_exist "$vhost_path" no; then
    debug "Backing up nginx config for ${domain} to ${vhost_backup_path}"
    cp "${vhost_path}" "${vhost_backup_path}"
  fi
  if need_to_regenerate_host_config "$vhost_path"; then
    command="${command}cp ${NGINX_KEITARO_CONF} "$vhost_path" && "
    changes="${changes}$(build_sed_expression_from_nginx_setting_block "listen 80" "listen 80 .*")"
    changes="${changes}$(build_sed_expression_from_nginx_setting_block "server_name ${domain}")"
  fi
  while isset "${3}"; do
    changes="${changes}$(build_sed_expression_from_nginx_setting_block "${3}")"
    shift
  done
  command="${command}sed -i${changes} ${vhost_path}"
  run_command "${command}" "${generating_message} ${domain}" "hide_output"
}


need_to_regenerate_host_config(){
  local vhost_path="${1}"
  ! is_file_exist "$vhost_path" no || ! vhost_config_relevant "$vhost_path"
}


vhost_config_relevant(){
  local vhost_path="${1}"
  grep -q -P "^# Generated by Keitaro .* v${RELEASE_VERSION}" "${vhost_path}"
}


get_vhost_path(){
  local domain="${1}"
  echo "${NGINX_VHOSTS_DIR}/${domain}.conf"
}

get_vhost_backup_path(){
  local domain="${1}"
  echo "${NGINX_VHOSTS_DIR}/${domain}.conf.$(date +%Y%m%d%H%M%S)"
}


build_sed_expression_from_nginx_setting_block(){
  local setting="${1}"
  local search_pattern="${2}"
  read name value <<< "$setting"
  if empty "$search_pattern"; then
    search_pattern="${name} .*"
  fi
  echo " -e 's|${search_pattern}|${name} ${value};|g'"
}



clean_up(){
  debug 'called clean_up()'
}


#





debug(){
  local message="${1}"
  local color="${2}"
  if empty "$color"; then
    color='light.green'
  fi
  print_with_color "$message" "$color" >> "$SCRIPT_LOG"
}


#





fail(){
  local message="${1}"
  local see_logs="${2}"
  log_and_print_err "*** $(translate errors.program_failed) ***"
  log_and_print_err "$message"
  if isset "$see_logs"; then
    log_and_print_err "$(translate errors.see_logs)"
  fi
  print_err
  clean_up
  exit ${FAILURE_RESULT}
}



init(){
  init_log
  force_utf8_input
  debug "Starting init stage: log basic info"
  debug "Command: ${SCRIPT_COMMAND}"
  debug "Script version: ${RELEASE_VERSION}"
  debug "User ID: "$EUID""
  debug "Current date time: $(date +'%Y-%m-%d %H:%M:%S %:z')"
  trap on_exit SIGHUP SIGINT SIGTERM
}



init_log(){
  if mkdir -p ${CONFIG_DIR} &> /dev/null; then
    > ${SCRIPT_LOG}
  else
    echo "Can't create keitaro config dir ${CONFIG_DIR}" >&2
    exit 1
  fi
}



log_and_print_err(){
  local message="${1}"
  print_err "$message" 'red'
  debug "$message" 'red'
}



on_exit(){
  debug "Terminated by user"
  echo
  clean_up
  fail "$(translate 'errors.terminated')"
}


#





print_content_of(){
  local filepath="${1}"
  if [ -f "$filepath" ]; then
    if [ -s "$filepath" ]; then
      echo "Content of '${filepath}':\n$(cat "$filepath" | add_indentation)"
    else
      echo "File '${filepath}' is empty"
    fi
  else
    echo "Can't show '${filepath}' content - file does not exist"
  fi
}



print_err(){
  local message="${1}"
  local color="${2}"
  print_with_color "$message" "$color" >&2
}


#





print_translated(){
  local key="${1}"
  message=$(translate "${key}")
  if ! empty "$message"; then
    echo "$message"
  fi
}


#





declare -A COLOR_CODE

COLOR_CODE['bold']=1

COLOR_CODE['default']=39
COLOR_CODE['red']=31
COLOR_CODE['green']=32
COLOR_CODE['yellow']=33
COLOR_CODE['blue']=34
COLOR_CODE['magenta']=35
COLOR_CODE['cyan']=36
COLOR_CODE['grey']=90
COLOR_CODE['light.red']=91
COLOR_CODE['light.green']=92
COLOR_CODE['light.yellow']=99
COLOR_CODE['light.blue']=94
COLOR_CODE['light.magenta']=95
COLOR_CODE['light.cyan']=96
COLOR_CODE['light.grey']=37

RESET_FORMATTING='\e[0m'


print_with_color(){
  local message="${1}"
  local color="${2}"
  if ! empty "$color"; then
    escape_sequence="\e[${COLOR_CODE[$color]}m"
    echo -e "${escape_sequence}${message}${RESET_FORMATTING}"
  else
    echo "$message"
  fi
}



reload_nginx(){
  debug "Reload nginx"
  run_command "nginx -s reload" "$(translate 'messages.reload_nginx')" 'hide_output'
}


#






run_command(){
  local command="${1}"
  local message="${2}"
  local hide_output="${3}"
  local allow_errors="${4}"
  local run_as="${5}"
  local print_fail_message_method="${6}"
  local output_log="${7}"
  debug "Evaluating command: ${command}"
  if empty "$message"; then
    run_command_message=$(print_with_color "$(translate 'messages.run_command')" 'blue')
    message="$run_command_message \`$command\`"
  else
    message=$(print_with_color "${message}" 'blue')
  fi
  if isset "$hide_output"; then
    echo -en "${message} . "
  else
    echo -e "${message}"
  fi
  if isset "$PRESERVE_RUNNING"; then
    print_command_status "$command" 'SKIPPED' 'yellow' "$hide_output"
    debug "Actual running disabled"
  else
    really_run_command "${command}" "${hide_output}" "${allow_errors}" "${run_as}" \
        "${print_fail_message_method}" "${output_log}"
      fi
    }


print_command_status(){
  local command="${1}"
  local status="${2}"
  local color="${3}"
  local hide_output="${4}"
  debug "Command result: ${status}"
  if isset "$hide_output"; then
    if [[ "$hide_output" =~ (uncolored_yes_no) ]]; then
      print_uncolored_yes_no "$status"
    else
      print_with_color "$status" "$color"
    fi
  fi
}


print_uncolored_yes_no(){
  local status="${1}"
  if [[ "$status" == "NOK" ]]; then
    echo "NO"
  else
    echo "YES"
  fi
}



really_run_command(){
  local command="${1}"
  local hide_output="${2}"
  local allow_errors="${3}"
  local run_as="${4}"
  local print_fail_message_method="${5}"
  local output_log="${6}"
  local current_command_script=$(save_command_script "${command}" "${run_as}")
  local evaluated_command=$(command_run_as "${current_command_script}" "${run_as}")
  evaluated_command=$(unbuffer_streams "${evaluated_command}")
  evaluated_command=$(save_command_logs "${evaluated_command}" "${output_log}")
  evaluated_command=$(hide_command_output "${evaluated_command}" "${hide_output}")
  debug "Real command: ${evaluated_command}"
  if ! eval "${evaluated_command}"; then
    print_command_status "${command}" 'NOK' 'red' "${hide_output}"
    if isset "$allow_errors"; then
      remove_current_command "$current_command_script"
      return ${FAILURE_RESULT}
    else
      fail_message=$(print_current_command_fail_message "$print_fail_message_method" "$current_command_script")
      remove_current_command "$current_command_script"
      fail "${fail_message}" "see_logs"
    fi
  else
    print_command_status "$command" 'OK' 'green' "$hide_output"
    remove_current_command "$current_command_script"
  fi
}


command_run_as(){
  local command="${1}"
  local run_as="${2}"
  if isset "$run_as"; then
    echo "sudo -u '${run_as}' bash -c '${command}'"
  else
    echo "bash ${command}"
  fi
}


unbuffer_streams(){
  local command="${1}"
  echo "stdbuf -i0 -o0 -e0 ${command}"
}


save_command_logs(){
  local evaluated_command="${1}"
  local output_log="${2}"
  save_output_log="tee -i ${CURRENT_COMMAND_OUTPUT_LOG} | tee -ia ${SCRIPT_LOG}"
  save_error_log="tee -i ${CURRENT_COMMAND_ERROR_LOG} | tee -ia ${SCRIPT_LOG}"
  if isset "${output_log}"; then
    save_output_log="${save_output_log} | tee -ia ${output_log}"
    save_error_log="${save_error_log} | tee -ia ${output_log}"
  fi
  echo "((${evaluated_command}) 2> >(${save_error_log}) > >(${save_output_log}))"
}


remove_colors_from_file(){
  local file="${1}"
  debug "Removing colors from file ${file}"
  sed -r -e 's/\x1b\[([0-9]{1,3}(;[0-9]{1,3}){,2})?[mGK]//g' -i "$file"
}


hide_command_output(){
  local command="${1}"
  local hide_output="${2}"
  if isset "$hide_output"; then
    echo "${command} > /dev/null"
  else
    echo "${command}"
  fi
}


save_command_script(){
  local command="${1}"
  local run_as="${2}"
  local current_command_dir=$(mktemp -d)
  if isset "$run_as"; then
    chown "$run_as" "$current_command_dir"
  fi
  local current_command_script="${current_command_dir}/${CURRENT_COMMAND_SCRIPT_NAME}"
  echo '#!/usr/bin/env bash' > "${current_command_script}"
  echo 'set -o pipefail' >> "${current_command_script}"
  echo -e "${command}" >> "${current_command_script}"
  debug "$(print_content_of ${current_command_script})"
  echo "${current_command_script}"
}


print_current_command_fail_message(){
  local print_fail_message_method="${1}"
  local current_command_script="${2}"
  remove_colors_from_file "${CURRENT_COMMAND_OUTPUT_LOG}"
  remove_colors_from_file "${CURRENT_COMMAND_ERROR_LOG}"
  if empty "$print_fail_message_method"; then
    print_fail_message_method="print_common_fail_message"
  fi
  local fail_message_header=$(translate 'errors.run_command.fail')
  local fail_message=$(eval "$print_fail_message_method" "$current_command_script")
  echo -e "${fail_message_header}\n${fail_message}"
}


print_common_fail_message(){
  local current_command_script="${1}"
  print_content_of ${current_command_script}
  print_tail_content_of "${CURRENT_COMMAND_OUTPUT_LOG}"
  print_tail_content_of "${CURRENT_COMMAND_ERROR_LOG}"
}


print_tail_content_of(){
  local file="${1}"
  MAX_LINES_COUNT=20
  print_content_of "${file}" |  tail -n "$MAX_LINES_COUNT"
}


remove_current_command(){
  local current_command_script="${1}"
  debug "Removing current command script and logs"
  rm -f "$CURRENT_COMMAND_OUTPUT_LOG" "$CURRENT_COMMAND_ERROR_LOG" "$current_command_script"
  rmdir $(dirname "$current_command_script")
}



get_host_ip(){
  hostname -I 2>/dev/null | tr ' ' "\n" | grep -oP '(\d+\.){3}\d+' \
    | grep -v '^10\.' | grep -vP '172\.(1[6-9]|2[0-9]|3[1-2])' | grep -v '192\.168\.' \
    | grep -v '127\.' \
    | head -n 1 \
    || true
  }



join_by(){
  local delimiter=$1
  shift
  echo -n "$1"
  shift
  printf "%s" "${@/#/${delimiter}}"
}



to_lower(){
  local string="${1}"
  echo "${string,,}"
}



get_error(){
  local var_name="${1}"
  local validation_methods_string="${2}"
  local value="${VARS[$var_name]}"
  local error=""
  read -ra validation_methods <<< "$validation_methods_string"
  for validation_method in "${validation_methods[@]}"; do
    if ! eval "${validation_method} '${value}'"; then
      debug "${var_name}: '${value}' invalid for ${validation_method} validator"
      error="${validation_method}"
      break
    else
      debug "${var_name}: '${value}' valid for ${validation_method} validator"
    fi
  done
  echo "${error}"
}


SUBDOMAIN_REGEXP="[[:alnum:]-]+"
DOMAIN_REGEXP="(${SUBDOMAIN_REGEXP}\.)+[[:alpha:]]${SUBDOMAIN_REGEXP}"

validate_domain(){
  local value="${1}"
  [[ "$value" =~ ^${DOMAIN_REGEXP}$ ]]
}


#





validate_presence(){
  local value="${1}"
  isset "$value"
}



is_no(){
  local answer="${1}"
  shopt -s nocasematch
  [[ "$answer" =~ ^(no|n|нет|н)$ ]]
}



is_yes(){
  local answer="${1}"
  shopt -s nocasematch
  [[ "$answer" =~ ^(yes|y|да|д)$ ]]
}



transform_to_yes_no(){
  local var_name="${1}"
  if is_yes "${VARS[$var_name]}"; then
    debug "Transform ${var_name}: ${VARS[$var_name]} => yes"
    VARS[$var_name]='yes'
  else
    debug "Transform ${var_name}: ${VARS[$var_name]} => no"
    VARS[$var_name]='no'
  fi
}


validate_yes_no(){
  local value="${1}"
  (is_yes "$value" || is_no "$value")
}




stage1(){
  debug "Starting stage 1: initial script setup"
  parse_options "$@"
  set_ui_lang
}


#





parse_options(){
  while getopts ":hpsl:ae:wv" opt; do
    case $opt in
      p)
        PRESERVE_RUNNING=true
        ;;
      s)
        SKIP_CHECKS=true
        ;;
      l)
        case $OPTARG in
          en)
            UI_LANG=en
            ;;
          ru)
            UI_LANG=ru
            ;;
          *)
            print_err "Specified language \"$OPTARG\" is not supported"
            exit ${FAILURE_RESULT}
            ;;
        esac
        ;;
      a)
        SKIP_SSL_AGREE_TOS=true
        ;;
      e)
        EMAIL="${OPTARG}"
        ;;
      w)
        SKIP_SSL_EMAIL=true
        ;;
      :)
        print_err "Option -$OPTARG requires an argument."
        exit ${FAILURE_RESULT}
        ;;
      h)
        usage
        exit ${SUCCESS_RESULT}
        ;;
      v)
        echo "${SCRIPT_NAME} v${RELEASE_VERSION}"
        exit ${SUCCESS_RESULT}
        ;;
      \?)
        usage
        exit ${FAILURE_RESULT}
        ;;
    esac
  done
  shift $((OPTIND-1))
  if [[ ${#} == 0 ]]; then
    usage
    exit ${FAILURE_RESULT}
  else
    while [[ ${#} -gt 0 ]]; do
      if [[ "$1" =~ (,) ]]; then
        usage
        exit ${FAILURE_RESULT}
      fi
      if [[ ! "${1}" =~ ^(-) ]]; then
        if validate_domain "${1}"; then
          DOMAINS+=("$(to_lower "${1}")")
        else
          set_ui_lang
          fail "$(translate 'errors.domain_invalid' "domain=${1}")"
        fi
      fi
      shift
    done
  fi
}


usage(){
  set_ui_lang
  if [[ "$UI_LANG" == 'ru' ]]; then
    ru_usage
  else
    en_usage
  fi
}


ru_usage(){
  print_err "$SCRIPT_NAME подключает SSL сертификат от Let's Encrypt для указанных доменов Keitaro"
  print_err
  print_err "Использование: "$SCRIPT_NAME" [-ps] [-l en|ru] [-e some.email@example.org] domain1.tld [domain2.tld] ..."
  print_err
  print_err "  -p"
  print_err "    С опцией -p (preserve commands running) "$SCRIPT_NAME" не выполняет установочные команды. Вместо этого текст команд будет показан на экране."
  print_err
  print_err "  -s"
  print_err "    С опцией -s (skip checks) "$SCRIPT_NAME" не будет проверять присутствие нужных программ в системе, не будет проверять факт запуска из под root."
  print_err
  print_err "  -l <lang>"
  print_err "    "$SCRIPT_NAME" определяет язык через установленные переменные окружения LANG/LC_MESSAGES/LC_ALL, однако язык может быть явно задан помощи параметра -l."
  print_err "    На данный момент поддерживаются значения en и ru (для английского и русского языков)."
  print_err
  print_err "  -e <email>"
  print_err "    Адрес электронной почты исползуемый для регистрации при получении бесплатных SSL сертификатов. Let's Encrypt"
  print_err
  print_err "  -w"
  print_err "    C опцией -w (without email) "$SCRIPT_NAME" не будет запрашивать у пользователя адрес электронной почты."
  print_err
}


en_usage(){
  print_err "$SCRIPT_NAME generates Let's Encrypt SSL for the specified domains of Keitaro"
  print_err
  print_err "Usage: "$SCRIPT_NAME" [-ps] [-l en|ru] domain1.tld [domain2.tld] ..."
  print_err
  print_err "  -p"
  print_err "    The -p (preserve commands running) option causes "$SCRIPT_NAME" to preserve the invoking of installation commands. Installation commands will be printed to stdout instead."
  print_err
  print_err "  -s"
  print_err "    The -s (skip checks) option causes "$SCRIPT_NAME" to skip checks of required programs presence, skip check root running"
  print_err
  print_err "  -l <lang>"
  print_err "    By default "$SCRIPT_NAME" tries to detect language from LANG/LC_MESSAGES/LC_ALL environment variables, but language can be explicitly set  with -l option."
  print_err "    Only en and ru (for English and Russian) values are supported now."
  print_err
  print_err "  -e <email>"
  print_err "    Email used for registration while getting Free SSL Let's Encrypt certificates."
  print_err
  print_err "  -w"
  print_err "    The -w (without email) option causes "$SCRIPT_NAME" to skip email request."
  print_err
}



stage2(){
  debug "Starting stage 2: make some asserts"
  assert_caller_root
  assert_server_configuration_relevant
}



stage3(){
  debug "Starting stage 3: get user vars"
  get_user_vars
}


#





get_user_vars(){
  debug 'Read vars from user input'
  hack_stdin_if_pipe_mode
  get_user_le_sa_agreement
  if is_yes ${VARS['ssl_agree_tos']}; then
    get_user_email
  else
    fail "$(translate 'prompts.ssl_agree_tos.help')"
  fi
}


get_user_le_sa_agreement(){
  VARS['ssl_agree_tos']='yes'
  if isset "$SKIP_SSL_AGREE_TOS"; then
    debug "Do not request SSL user agreement because appropriate option specified"
  else
    get_user_var 'ssl_agree_tos' 'validate_yes_no'
  fi
}


get_user_email(){
  if isset "$SKIP_SSL_EMAIL"; then
    debug "Do not request SSL email because appropriate option specified"
  else
    if isset "$EMAIL"; then
      debug "Do not request SSL email because email specified by option"
      VARS['ssl_email']="${EMAIL}"
    else
      get_user_var 'ssl_email'
    fi
  fi
}


#





stage4(){
  debug "Starting stage 4: install LE certificates"
  generate_certificates
  add_renewal_job
  if isset "$SUCCESSFUL_DOMAINS"; then
    reload_nginx
  fi
  show_finishing_message
}



add_renewal_job(){
  debug "Add renewal certificates cron job"
  if renewal_job_installed; then
    debug "Renewal cron job already scheduled"
    print_translated 'messages.relevant_renewal_job_already_scheduled'
  else
    schedule_renewal_job
  fi
}


schedule_renewal_job(){
  debug "Schedule renewal job"
  local hour="$(date +'%H')"
  local minute="$(date +'%M')"
  local renew_cmd='certbot renew --allow-subset-of-names --quiet --renew-hook \"systemctl reload nginx\"'
  local renew_job="${minute} ${hour} * * * ${renew_cmd}"
  local schedule_renewal_job_cmd="(crontab -l; echo \"${renew_job}\") | crontab -"
  run_command "${schedule_renewal_job_cmd}" "$(translate 'messages.schedule_renewal_job')" "hide_output"
}


renewal_job_installed(){
  local command="crontab  -l | grep -q 'certbot renew'"
  run_command "${command}" "$(translate 'messages.check_renewal_job_scheduled')" "hide_output uncolored_yes_no" "allow_errors"
}


#





generate_certificates(){
  debug "Requesting certificates"
  echo -n > "$SSL_ENABLER_ERRORS_LOG"
  for domain in "${DOMAINS[@]}"; do
    certificate_generated=${FALSE}
    certificate_error=""
    if certificate_exists_for_domain "$domain"; then
      SUCCESSFUL_DOMAINS+=($domain)
      debug "Certificate already exists for domain ${domain}"
      print_with_color "${domain}: $(translate 'warnings.certificate_exists_for_domain')" "yellow"
      certificate_generated=${TRUE}
    else
      debug "Certificate for domain ${domain} does not exist"
      if request_certificate_for "${domain}"; then
        SUCCESSFUL_DOMAINS+=($domain)
        debug "Certificate for domain ${domain} successfully issued"
        certificate_generated=${TRUE}
        rm -rf "$CERTBOT_LOG"
      else
        FAILED_DOMAINS+=($domain)
        debug "There was an error while issuing certificate for domain ${domain}"
        certificate_error="$(recognize_error "$CERTBOT_LOG")"
        echo "${domain}: ${certificate_error}" >> "$SSL_ENABLER_ERRORS_LOG"
      fi
    fi
    if [[ ${certificate_generated} == ${TRUE} ]]; then
      debug "Generating nginx config for ${domain}"
      setup_le_certs_in_vhost_config "${domain}"
    else
      debug "Skip generation nginx config ${domain} due errors while cert issuing"
      print_with_color "${domain}: ${certificate_error}" "red"
      print_with_color "${domain}: $(translate 'warnings.skip_nginx_config_generation')" "yellow"
    fi
  done
  rm -f "${CERT_DOMAINS_PATH}"
}


certificate_exists_for_domain(){
  local domain="${1}"
  is_directory_exist "/etc/letsencrypt/live/${domain}" "no"
}


request_certificate_for(){
  local domain="${1}"
  debug "Requesting certificate for domain ${domain}"
  certbot_command="certbot certonly --webroot --webroot-path=${WEBROOT_PATH}"
  certbot_command="${certbot_command} --agree-tos --non-interactive"
  certbot_command="${certbot_command} --domain ${domain}"
  if isset "${VARS['ssl_email']}"; then
    certbot_command="${certbot_command} --email ${VARS['ssl_email']}"
  else
    certbot_command="${certbot_command} --register-unsafely-without-email"
  fi
  requesting_message="$(translate "messages.requesting_certificate_for") ${domain}"
  run_command "${certbot_command}" "${requesting_message}" "hide_output" "allow_errors" "" "" "$CERTBOT_LOG"
}



setup_le_certs_in_vhost_config(){
  local domain="${1}"
  local certs_root_path="/etc/letsencrypt/live/${domain}"
  regenerate_vhost_config "$domain" 'messages.generating_nginx_config_for' \
    "ssl_certificate ${certs_root_path}/fullchain.pem" \
    "ssl_certificate_key ${certs_root_path}/privkey.pem"
  }


#






show_finishing_message(){
  local color=""
  if isset "$SUCCESSFUL_DOMAINS" && empty "$FAILED_DOMAINS"; then
    print_with_color "$(translate 'messages.successful')" 'green'
    print_enabled_domains
  fi
  if isset "$SUCCESSFUL_DOMAINS" && isset "$FAILED_DOMAINS"; then
    print_enabled_domains
    print_not_enabled_domains 'yellow'
  fi
  if empty "$SUCCESSFUL_DOMAINS" && isset "$FAILED_DOMAINS"; then
    print_not_enabled_domains 'red'
  fi
}


print_enabled_domains(){
  message="$(translate 'messages.ssl_enabled_for_domains')"
  domains=$(join_by ", " "${SUCCESSFUL_DOMAINS[@]}")
  print_with_color "OK. ${message} ${domains}" 'green'
}


print_not_enabled_domains(){
  local color="${1}"
  message="$(translate 'messages.ssl_not_enabled_for_domains')"
  domains=$(join_by ", " "${FAILED_DOMAINS[@]}")
  print_with_color "NOK. ${message} ${domains}" "${color}"
  print_with_color "$(cat "$SSL_ENABLER_ERRORS_LOG")" "${color}"
}



recognize_error() {
  local certbot_log="${1}"
  local key="unknown_error"
  debug "$(print_content_of ${certbot_log})"
  if grep -q '^There were too many requests' "${certbot_log}"; then
    key="too_many_requests"
  else
    local error_detail=$(grep '^   Detail:' "${certbot_log}" 2>/dev/null)
    debug "certbot error detail from ${certbot_log}: ${error_detail}"
    if [[ $error_detail =~ "NXDOMAIN looking up A" ]]; then
      key="wrong_a_entry"
    elif [[ $error_detail =~ "No valid IP addresses found" ]]; then
      key="wrong_a_entry"
    elif [[ $error_detail =~ "Invalid response from" ]]; then
      key="wrong_a_entry"
    fi
  fi
  debug "The error key is ${key}"
  print_translated "certbot_errors.${key}"
}



enable_ssl(){
  init "$@"
  stage1 "$@"
  stage2
  stage3
  stage4
}


enable_ssl "$@"

# wait for all async child processes (because "await ... then" is used in powscript)
[[ $ASYNC == 1 ]] && wait


exit 0

