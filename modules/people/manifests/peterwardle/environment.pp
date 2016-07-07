class people::peterwardle::environment {

    include people::peterwardle::environment::ssh
    include people::peterwardle::environment::dotfiles

    package { 'zsh': }

    # Changes the default shell to the zsh version we get from Homebrew
    # Uses the osx_chsh type out of boxen/puppet-osx
    osx_chsh { $::luser:
        shell   => '/usr/local/bin/zsh',
        require => Package['zsh'],
    }

    file_line { 'add zsh to /etc/shells':
        path    => '/etc/shells',
        line    => "/usr/local/bin/zsh",
        require => Package['zsh'],
    }

    repository { 'src/powerline-fonts':
        path   => "${::boxen_srcdir}/powerline-fonts",
        source => "powerline/fonts",
    }

    exec { 'install powerline fonts':
        command => 'bash ./install.sh',
        cwd     => "${::boxen_srcdir}/powerline-fonts",
        require => Repository['src/powerline-fonts'],
    }
}
