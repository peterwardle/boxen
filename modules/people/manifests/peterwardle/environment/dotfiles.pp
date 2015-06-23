class people::peterwardle::environment::dotfiles {

    repository { "${::boxen_srcdir}/dotfiles":
        source  => 'git@bitbucket.org:peterwardle/dotfiles.git',
    }
    repository { "${::boxen_srcdir}/oh-my-zsh":
        source  => 'robbyrussell/oh-my-zsh',
    }

    file { "/Users/${::boxen_user}/.oh-my-zsh":
        ensure  => link,
        target  => "${::boxen_srcdir}/oh-my-zsh",
        require => Repository["${::boxen_srcdir}/oh-my-zsh"],
    }

    file { "/Users/${::boxen_user}/.zshrc":
        ensure  => link,
        mode    => '0644',
        target  => "${::boxen_srcdir}/dotfiles/zshrc",
        require => Repository["${::boxen_srcdir}/dotfiles"],
    }

    file { "/Users/${::boxen_user}/.vim":
        ensure  => link,
        mode    => '0644',
        target  => "${::boxen_srcdir}/dotfiles/vim",
        require => Repository["${::boxen_srcdir}/dotfiles"],
    }

    file { "/Users/${::boxen_user}/.vimrc":
        ensure  => link,
        mode    => '0644',
        target  => "${::boxen_srcdir}/dotfiles/vimrc",
        require => Repository["${::boxen_srcdir}/dotfiles"],
    }
}