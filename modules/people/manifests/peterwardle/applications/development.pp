class people::peterwardle::applications::development {

    $applications = [
        'paw',
        'sequel-pro',
        'virtualbox',
        'vagrant',
    ]

    package { $applications:
        provider => 'brewcask',
    }

    exec { 'install vagrant-cachier':
        unless  => 'vagrant plugin list | grep vagrant-cachier &> /dev/null',
        command => 'vagrant plugin install vagrant-cachier',
        require => Package['vagrant'],
    }

    exec { 'install composer':
        creates => '/usr/local/bin/composer',
        command => 'curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename composer',
    }
    
    include people::peterwardle::applications::sublime
}