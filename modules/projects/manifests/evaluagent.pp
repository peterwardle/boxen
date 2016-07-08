class projects::evaluagent {

    $applications = [
        'docker',
        'hipchat',
        'skype'
    ]

    package { $applications:
        provider => 'brewcask',
    }

    package {
        [
            'kubernetes-cli'
        ]:
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

    $scripts = ['docker', 'docker-machine', 'docker-compose']

    # Puppet > 4.0
    # $scripts.each |String $script| {
    #     file { "/usr/local/etc/bash_completion.d/${script}.bash-completion":
    #         ensure => "/Applications/Docker.app/Contents/Resources/etc/${script}.bash-completion",
    #         require => Exec['docker'],
    #     }
    # }

    define bash::completion::symlink ($src, $script = $title) {
        file {"/usr/local/etc/bash_completion.d/${script}.bash-completion":
            ensure => "${src}/${script}.bash-completion",
        }
    }
    bash::completion::symlink { $scripts:
        src => '/Applications/Docker.app/Contents/Resources/etc',
    }
}
