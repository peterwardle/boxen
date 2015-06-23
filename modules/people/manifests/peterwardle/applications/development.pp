class people::peterwardle::applications::development {

    $applications = [
        'paw',
        'sequel-pro',
        'virtualbox',
        'vagrant',
    ]

    package { $applications:
        provider => 'brewcask',
    }
    
    include people::peterwardle::applications::sublime
}