# frozen_string_literal: true

default['openvpnas']['version']                                 = '2.7.5'
default['openvpnas']['ubuntu_version']                          = 'Ubuntu18'
default['openvpnas']['admin_username']                          = ''   # mariusmitrofan
default['openvpnas']['config_path']                             = '/tmp'
default['openvpnas']['config_script']                           = '/tmp'

default['openvpnas']['admin_ui.https.ip_address']               = 'all'
default['openvpnas']['admin_ui.https.port']                     = ''   # 443
default['openvpnas']['aui.eula_version']                        = '2'
default['openvpnas']['auth.ldap.0.add_req']                     = ''   # memberOf=CN=VPN,OU=Groups,OU=NETBEARS,DC=netbears,DC=com
default['openvpnas']['auth.ldap.0.bind_dn']                     = ''   # openvpn@netbears.com
default['openvpnas']['auth.ldap.0.bind_pw']                     = DecryptSecrets::Helper.decrypt(node['openvpnas']['auth.ldap.0.bind_pw_encrypted'])
default['openvpnas']['auth.ldap.0.name']                        = 'My LDAP servers'
default['openvpnas']['auth.ldap.0.server.0.host']               = ''   # LDAP IP1:389
default['openvpnas']['auth.ldap.0.server.1.host']               = ''   # LDAP IP2:389
default['openvpnas']['auth.ldap.0.ssl_verify']                  = 'internal'
default['openvpnas']['auth.ldap.0.timeout']                     = '4'
default['openvpnas']['auth.ldap.0.uname_attr']                  = 'sAMAccountName'
default['openvpnas']['auth.ldap.0.use_ssl']                     = 'never'
default['openvpnas']['auth.ldap.0.users_base_dn']               = ''   # OU=Users,OU=NETBEARS,DC=netbears,DC=com
default['openvpnas']['auth.module.type']                        = 'ldap'
default['openvpnas']['cs.https.ip_address']                     = 'all'
default['openvpnas']['cs.https.port']                           = ''   # 443
default['openvpnas']['host.name']                               = ''   # vpn.aws.netbears.com
default['openvpnas']['vpn.client.routing.inter_client']         = ''   # false
default['openvpnas']['vpn.client.routing.reroute_dns']          = 'false'
default['openvpnas']['vpn.client.routing.reroute_gw']           = ''   # false
default['openvpnas']['vpn.client.routing.superuser_c2c_access'] = 'true'
default['openvpnas']['vpn.client.config_text']                  = ''
default['openvpnas']['vpn.daemon.0.client.netmask_bits']        = ''   # 20
default['openvpnas']['vpn.daemon.0.client.network']             = ''   # 172.20.112.0
default['openvpnas']['vpn.daemon.0.listen.ip_address']          = 'all'
default['openvpnas']['vpn.daemon.0.listen.port']                = ''   # 80
default['openvpnas']['vpn.daemon.0.listen.protocol']            = ''   # tcp
default['openvpnas']['vpn.daemon.0.server.ip_address']          = 'all'
default['openvpnas']['vpn.server.daemon.enable']                = 'false'
default['openvpnas']['vpn.server.routing.gateway_access']       = 'false'
default['openvpnas']['vpn.server.routing.private_access']       = 'nat'
default['openvpnas']['vpn.server.routing.private_network.0']    = ''   # 172.20.0.0/16
default['openvpnas']['vpn.server.routing.private_network.1']    = ''   # 172.17.0.0/16
default['openvpnas']['vpn.server.routing.private_network.2']    = ''   # 172.23.0.0/16
default['openvpnas']['vpn.server.duplicate_cn']                 = 'false'
default['openvpnas']['vpn.server.config_text']                  = ''
default['openvpnas']['enable_mfa']                              = 'false'
