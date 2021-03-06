#!/usr/bin/env bash

setup_le_certs_in_vhost_config(){
  local domain="${1}"
  local certs_root_path="/etc/letsencrypt/live/${domain}"
  regenerate_vhost_config "$domain" 'messages.generating_nginx_config_for' \
    "ssl_certificate ${certs_root_path}/fullchain.pem" \
    "ssl_certificate_key ${certs_root_path}/privkey.pem"
  }
