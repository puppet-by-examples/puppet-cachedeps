class cachedeps {

    vcsrepo { '/tmp/symfony-standard':
        ensure   => 'present'
        provider => 'git',
        source   => 'https://github.com/symfony/symfony-standard.git',
        user     => 'vagrant',
        revision => 'v2.6.1'
    }

    exec { 'cachedeps-composer-install':
        command     => 'composer install -q',
        environment => 'HOME=/home/vagrant',
        cwd         => '/tmp/symfony-standard',
        path        => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
        require     => [Vcsrepo['/tmp/symfony-standard']]
    }

    exec { 'cachedeps-rm':
        command => 'rm -rf /tmp/symfony-standard',
        path    => '/usr/bin:/bin:/usr/sbin:/sbin',
        require => [Exec['cachedeps-composer-install']]
    }

}
