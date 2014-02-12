$dependencies = [
    "php5",
    "php-apc",
    "php5-cli",
    "php5-curl",
    "php5-gd",
    "php5-json",
    "php5-imagick",
    "php5-intl",
    "php5-mcrypt",
    "php5-memcache",
    "php5-memcached",
    "php5-odbc",
    "php5-sqlite",
    "php5-tidy",
    "php5-xdebug",
    "php5-xmlrpc",
    "php5-xsl",
    "git",
    "vim",
    "sendmail",
]

package { $dependencies:
    ensure  => present,
    require => Exec['apt-update'],
}

exec { "apt-update":
    command => "/usr/bin/apt-get update",
}

file { "/var/www/app.local":
    ensure  => "directory",
    #owner   => "www-data",
    #group   => "www-data",
    #mode    => "0775",
    recurse => true,
}

class { "apache": 
    mpm_module    => 'prefork',
    default_vhost => false,
}

class { "apache::mod::alias": }
class { "apache::mod::auth_basic": }
class { "apache::mod::cache": }
class { "apache::mod::cgi": }
class { "apache::mod::dav": }
class { "apache::mod::dav_fs": }
class { "apache::mod::deflate": }
class { "apache::mod::dir": }
class { "apache::mod::expires": }
class { "apache::mod::headers": }
class { "apache::mod::include": }
class { "apache::mod::info": }
class { "apache::mod::ldap": }
class { "apache::mod::mime": }
class { "apache::mod::mime_magic": }
class { "apache::mod::negotiation": }
class { "apache::mod::php": }
class { "apache::mod::proxy": }
class { "apache::mod::proxy_ajp": }
class { "apache::mod::proxy_balancer": }
class { "apache::mod::proxy_http": }
class { "apache::mod::rewrite": }
class { "apache::mod::rewrite": }
class { "apache::mod::setenvif": }
class { "apache::mod::ssl": }
class { "apache::mod::status": }
class { "apache::mod::userdir": }
class { "apache::mod::vhost_alias": }


class { '::mysql::server':
    root_password => 'password',
    override_options => {
        'mysqld' => { 
            'max_connections' => '1024',
        } 
    },
    databases => {
        'database' => {
            ensure  => 'present',
            charset => 'utf8',
        },
    },
}

# vhost config files
import 'vhosts/*.pp'