class people::peterwardle::environment::dotfiles {

    File { mode => '0644' }

    repository { 'dotfiles':
        path    => "${::boxen_srcdir}/dotfiles",
        source  => 'git@bitbucket.org:peterwardle/dotfiles.git',
    }
    repository { 'oh-my-zsh':
        path    => "${::boxen_srcdir}/oh-my-zsh",
        source  => 'robbyrussell/oh-my-zsh',
    }

    file { "user/.oh-my-zsh":
        ensure  => link,
        path    => "/Users/${::boxen_user}/.oh-my-zsh",
        target  => "${::boxen_srcdir}/oh-my-zsh",
        require => Repository['oh-my-zsh'],
    }

    file { "user/.zshrc":
        ensure  => link,
        path    => "/Users/${::boxen_user}/.zshrc",
        target  => "${::boxen_srcdir}/dotfiles/zshrc",
        require => Repository['dotfiles'],
    }

    file { "user/.vim":
        ensure  => link,
        path    => "/Users/${::boxen_user}/.vim",
        target  => "${::boxen_srcdir}/dotfiles/vim",
        require => Repository['dotfiles'],
    }

    file { "user/.vimrc":
        ensure  => link,
        path    => "/Users/${::boxen_user}/.vimrc",
        target  => "${::boxen_srcdir}/dotfiles/vimrc",
        require => Repository['dotfiles'],
    }

    file { "user/.gitconfig":
        ensure  => link,
        path    => "/Users/${::boxen_user}/.gitconfig",
        target  => "${::boxen_srcdir}/dotfiles/gitconfig",
        require => Repository['dotfiles'],
    }

    file { "User .gitignore":
        ensure  => link,
        path    => "/Users/${::boxen_user}/.gitignore",
        target  => "${::boxen_srcdir}/dotfiles/gitignore",
        require => Repository['dotfiles'],
    }
}