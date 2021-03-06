class people::peterwardle::applications {

    homebrew::tap { 'caskroom/versions': }

    package { [
            'iterm2',
            'google-chrome',
            'slack',
            'dropbox',
            '1password',
            'macdown',
            'evernote',
            'alfred',
            'viscosity',
            'spotify',
            'airfoil',
            'spectacle',
            'telegram',
            'vlc',
            'paw',
            'sequel-pro',
            'virtualbox',
            'vagrant',
            'atom',
            'sublime-text'
        ]:
        provider => 'brewcask',
    }

    repository { 'src/appconfig':
        path   => "${::boxen_srcdir}/appconfig",
        source => 'git@bitbucket.org:peterwardle/appconfig.git'
    }

    include people::peterwardle::applications::sublime
    include people::peterwardle::applications::atom
    include people::peterwardle::applications::vagrant
}
