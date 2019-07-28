# frozen_string_literal: true

name             'openvpn_stack'
maintainer       'NETBEARS'
license          'All rights reserved'
description      'Installs/Configures openvpn_stack'
long_description 'Installs/Configures openvpn_stack'
version          '1.0.0'

depends 'apt'
depends 'sysctl'

gem 'aws-sdk', '~> 2.7'

supports 'ubuntu'
