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
    "php5-mysql",
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
}

file { "/var/www/app.local/data":
    ensure  => "directory",
    group   => "www-data",
    mode    => "0755",
    recurse => true,
    require => File['/var/www/app.local'],
}

class { "apache": 
    mpm_module    => 'prefork',
    default_vhost => false,
}

class { "apache::mod::headers": }
class { "apache::mod::php": }
class { "apache::mod::rewrite": }
class { "apache::mod::ssl": }

class { '::mysql::server':
    root_password => 'password',
    override_options => {
        'client' => {
            'default-character-set' => 'utf8'
        },
        'mysql' => {
            'default-character-set' => 'utf8'
        },
        'mysqld' => {
            'collation-server' => 'utf8_unicode_ci',
            'init-connect' => 'SET NAMES utf8',
            'character-set-server' => 'utf8',
            'max_connections' => '1024',
            'skip-external-locking' => nil,
            'skip-name-resolve' => nil
        }
    }
}

mysql::db { 'database':
  user     => 'dbuser',
  password => 'password',
  host     => 'localhost',
  grant    => ['ALL'],
  sql      => '/var/www/app.local/puppet/sql/bk.dev.sql',
  import_timeout => 900,
}

# vhost config files
import 'vhosts/*.pp'