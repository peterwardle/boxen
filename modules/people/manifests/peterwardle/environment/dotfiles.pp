class people::peterwardle::environment::dotfiles {

    repository { "${::boxen_srcdir}/dotfiles":
        source  => 'git@bitbucket.org:peterwardle/dotfiles.git',
    }
    repository { "${::boxen_srcdir}/oh-my-zsh":
        source  => 'robbyrussell/oh-my-zsh',
    }

    File {
        mode => '0644',
    }

    file { "/Users/${::boxen_user}/.oh-my-zsh":
        ensure  => link,
        target  => "${::boxen_srcdir}/oh-my-zsh",
        require => Repository["${::boxen_srcdir}/oh-my-zsh"],
    }

    file { "/Users/${::boxen_user}/.zshrc":
        ensure  => link,
        target  => "${::boxen_srcdir}/dotfiles/zshrc",
        require => Repository["${::boxen_srcdir}/dotfiles"],
    }

    file { "/Users/${::boxen_user}/.vim":
        ensure  => link,
        target  => "${::boxen_srcdir}/dotfiles/vim",
        require => Repository["${::boxen_srcdir}/dotfiles"],
    }

    file { "/Users/${::boxen_user}/.vimrc":
        ensure  => link,
        target  => "${::boxen_srcdir}/dotfiles/vimrc",
        require => Repository["${::boxen_srcdir}/dotfiles"],
    }

    file { "/Users/${::boxen_user}/.gitconfig":
        ensure  => link,
        target  => "${::boxen_srcdir}/dotfiles/gitconfig",
        require => Repository["${::boxen_srcdir}/dotfiles"],
    }

    file { "/Users/${::boxen_user}/.gitignore":
        ensure  => link,
        target  => "${::boxen_srcdir}/dotfiles/gitignore",
        require => Repository["${::boxen_srcdir}/dotfiles"],
    }
}