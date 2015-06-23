class people::peterwardle::applications {

    $applications = [
        'iterm2',
        'google-chrome',
        'slack',
        'dropbox',
        '1password',
        'macdown',
        'evernote',
        'alfred',
        'viscosity',
    ]

    package { $applications:
        provider => 'brewcask',
    }
    
    include people::peterwardle::applications::development
    include people::peterwardle::applications::config
}