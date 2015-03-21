apache::vhost { 'app.local':
    priority   => 001,
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
            options        => ['+FollowSymlinks'],
            directoryindex => 'index.php',
            order          => 'allow,deny',
            allow_override => ['All'],
            allow          => 'from all',
        },
    ],
}
apache::vhost { 'app.local-ssl':
    priority   => 002,
    port       => 443,
    docroot    => '/var/www/app.local/public',
    ssl        => true,
    servername => 'app.local',
    ensure     => present,
    require    => File['/var/www/app.local'],
    log_level  => 'notice',
    setenv     => ['APPLICATION_ENV development'],
    directories => [
        {
            path           => '/var/www/app.local/public',
            options        => ['+FollowSymlinks'],
            directoryindex => 'index.php',
            order          => 'allow,deny',
            allow_override => ['All'],
            allow          => 'from all',
        },
    ],
}
