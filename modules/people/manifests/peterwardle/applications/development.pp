class people::peterwardle::applications::development {

    $tools = [
        'go',
        'node',
        'jq',
        'phantomjs',
        'ngrep',
        'goaccess',
    ]

    $applications = [
        'paw',
        'sequel-pro',
        'virtualbox',
        'vagrant',
    ]

    package { $tools: }

    package { $applications:
        provider => 'brewcask',
    }

    exec { 'install grunt-cli':
        creates => '/opt/boxen/homebrew/bin/grunt',
        command => 'npm install -g grunt-cli',
        user    => 'root',
        require => Package['node'],
    }

    exec { 'install bower':
        creates => '/opt/boxen/homebrew/bin/bower',
        command => 'npm install -g bower',
        user    => 'root',
        require => Package['node'],
    }

    exec { 'install jekyll':
        creates => '/usr/bin/jekyll',
        command => 'gem install jekyll',
        user    => 'root',
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

    exec { 'install bundler':
        creates => '/usr/bin/bundle',
        command => 'gem install bundler',
        user    => 'root',
    }
    
    include people::peterwardle::applications::sublime
}