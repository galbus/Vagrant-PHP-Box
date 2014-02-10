apache::vhost { 'app.local':
    priority   => 000,
    port       => 80,
    docroot    => '/var/www/app.local/public',
    ssl        => false,
    servername => 'app.local',
    ensure     => present,
    require    => File['/var/www/app.local'],
    log_level  => 'notice',
    setenv     => ['APPLICATION_ENV development'],
    directories => [
        { 
            path           => '/var/www/app.local/public', 
#            options        => ['+FollowSymlinks MultiViews'],
            options        => ['+FollowSymlinks'],
            directoryIndex => 'index.php', 
            override       => ['All'],
            order          => 'allow,deny',
            allow          => 'from all',
        },
    ],
}
