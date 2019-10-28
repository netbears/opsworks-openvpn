# frozen_string_literal: true

default['base_packages'] = %w[
  zip
  unzip
  curl
  wget
  jq
  python3
  libmysqlclient-dev
  net-tools
]
default['custom_packages']            = []

default['application']                = 'openvpn'
