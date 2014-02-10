apache::vhost { "app.local":
    priority   => 000,
    port       => 80,
    docroot    => "/var/www/app.local/public",
    ssl        => false,
    servername => "app.local",
    options    => ["FollowSymlinks MultiViews"],
    override   => ["All"],
    ensure     => present,
    require    => File['/var/www/app.local'],
	log_level  => 'notice',
}
