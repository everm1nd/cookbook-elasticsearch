maintainer       "karmi"
maintainer_email "karmi@karmi.cz"
license          "MIT License"
description      "Installs and configures elasticsearch clusters"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.markdown'))
version          "0.0.4"
name             "elasticsearch"

depends 'ark'

recommends 'java'

provides 'elasticsearch'
provides 'runit_service[elasticsearch]'
