class people::peterwardle {
    
    sudoers{ 'allow passwordless sudo':
        users    => "${boxen_user}",
        type     => 'user_spec',
        commands => '(ALL) ALL',
        hosts    => 'ALL', 
    }

    include people::peterwardle::settings
    include people::peterwardle::environment
    include people::peterwardle::applications
}