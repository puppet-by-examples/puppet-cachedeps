class cachedeps {

    file { '/tmp/symfony-standard':
        ensure  => directory,
        mode    => 0777,
        owner   => 'vagrant',
        group   => 'vagrant'
    }

    exec { 'cachedeps-get-composer-json':
        command => "wget -O /tmp/symfony-standard/composer.json https://raw.githubusercontent.com/symfony/symfony-standard/2.6/composer.json",
        path    => '/usr/bin:/bin:/usr/sbin:/sbin',
        onlyif  => 'test ! -f /tmp/symfony-standard/composer.json',
        require => File['/tmp/symfony-standard']
    }

    exec { 'cachedeps-composer-install':
        command     => "composer install",
        environment => 'HOME=/home/vagrant',
        cwd         => "/tmp/symfony-standard",
        path        => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require     => [File['/tmp/symfony-standard'], Exec['cachedeps-get-composer-json']]
    }

    exec { 'cachedeps-rm':
        command => "rm -rf /tmp/symfony-standard",
        path    => '/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Exec['cachedeps-composer-install']]
    }

}
