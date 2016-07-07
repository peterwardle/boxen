class projects::evaluagent {

    $applications = [
        'docker',
        'hipchat',
        'skype'
    ]

    package { $applications:
        provider => 'brewcask',
    }

    exec { 'download awscli':
        unless  => 'test -e /usr/local/bin/aws',
        creates => '/tmp/awscli-bundle',
        cwd => '/tmp',
        command => 'curl -s "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && unzip awscli-bundle.zip',
    }

    exec { 'install awscli':
        creates => '/usr/local/bin/aws',
        cwd => '/tmp',
        command => 'sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws',
        require => Exec['download awscli'],
    }
}
