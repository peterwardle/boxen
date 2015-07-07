class people::peterwardle::environment::ssh {

    repository { 'ssh':
        path    => "${::boxen_srcdir}/ssh",
        source  => 'git@bitbucket.org:peterwardle/ssh.git',
    }

    file { '/usr/local/bin/ssh-key':
        path    => '/usr/local/bin/ssh-key',
        target  => "${::boxen_srcdir}/ssh/bin/ssh-key",
        ensure  => link,
        mode    => 'a+x',
        require => File['ssh/keys'],
    }

    file { 'ssh/config':
        path    => "/Users/${::boxen_user}/.ssh/config",
        target  => "${::boxen_srcdir}/ssh/config",
        ensure  => link,
        mode    => '0644',
        require => Repository['ssh'],
    }

    file { 'ssh/known_hosts':
        path    => "/Users/${::boxen_user}/.ssh/known_hosts",
        target  => "${::boxen_srcdir}/ssh/known_hosts",
        ensure  => link,
        mode    => '0644',
        require => Repository['ssh'],
    }

    file { 'ssh/keys':
        path    => "/Users/${::boxen_user}/.ssh/keys",
        target  => "${::boxen_srcdir}/ssh/keys",
        ensure  => link,
        mode    => '0644',
        require => Repository['ssh'],
    }
}