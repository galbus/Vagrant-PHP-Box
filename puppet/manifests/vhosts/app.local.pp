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
    override   => ['All'],
    directories => [
        { 
            path           => '/var/www/app.local/public', 
            options        => ['+FollowSymlinks'],
            directoryindex => 'index.php', 
            order          => 'allow,deny',
            allow          => 'from all',
        },
    ],
}
