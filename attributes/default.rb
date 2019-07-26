# frozen_string_literal: true

default['openvpnas']['version']                                       = '2.6.1'
default['openvpnas']['ubuntu_version']                                = 'Ubuntu18'
default['openvpnas']['pass']                                          = ''

default['openvpnas']['https']['ip_address']                           = ''
default['openvpnas']['https']['port']                                 = ''

default['openvpnas']['ldap']['bind_dn']                               = ''
default['openvpnas']['ldap']['bind_pw']                               = ''
default['openvpnas']['ldap']['host']                                  = ''
default['openvpnas']['ldap']['ssl_verify']                            = 'never'
default['openvpnas']['ldap']['uname_attr']                            = 'cn'
default['openvpnas']['ldap']['use_ssl']                               = 'never'
default['openvpnas']['ldap']['users_base_dn']                         = ''
default['openvpnas']['ldap']['add_req']                         			= ''

default['openvpnas']['host']['name']                                  = ''
default['openvpnas']['daemon']['client']['netmask_bits']              = '16'
default['openvpnas']['daemon']['client']['network']                   = '10.8.0.0'

default['openvpnas']['server']['daemon']['tcp']['port']               = '80'
default['openvpnas']['server']['daemon']['udp']['port']               = '1194'


default['openvpnas']['server']['routing']['reroute_dns']           		= 'false'
default['openvpnas']['server']['routing']['reroute_gw']           		= 'false'
default['openvpnas']['server']['routing']['gateway_access']           = 'true'
default['openvpnas']['server']['routing']['private_access']           = 'nat'
default['openvpnas']['server']['routing']['private_network']['0']     = ''
default['openvpnas']['server']['routing']['private_network']['1']     = ''
default['openvpnas']['server']['routing']['private_network']['2']     = ''
default['openvpnas']['server']['routing']['private_network']['3']     = ''
default['openvpnas']['server']['routing']['routed_subnets']['0']      = ''

default['openvpnas']['server']['tls_auth']                            = 'true'
default['openvpnas']['server']['tls_version_min']                     = '1.2'
default['openvpnas']['server']['do_reauth']                           = 'true'
default['openvpnas']['server']['interval']                            = '360'
