class people::peterwardle {

    define symlink($source_dir, $destination_dir) {
        file { "Symlink ${name}: from '${source_dir}' to '${destination_dir}'":
            ensure  => link,
            path    => "${destination_dir}/${name}",
            target  => "${source_dir}/${name}",
        }
    }
    
    sudoers{ 'allow passwordless sudo for user':
        users    => "${boxen_user}",
        type     => 'user_spec',
        commands => '(ALL) NOPASSWD: ALL',
        hosts    => 'ALL', 
    }

    define machineidentifiers {
        $machine_identifier = "${boxen_user}-mbpr"
        exec { "Set ${title}":
            unless  => "test '${machine_identifier}' = `scutil --get ${title}`",
            command => "scutil --set ${title} '${machine_identifier}'",
            user    => root,
        }
    }

    machineidentifiers { ['ComputerName', 'LocalHostName', 'HostName']: }

    include people::peterwardle::settings
    include people::peterwardle::environment
    include people::peterwardle::applications
    include people::peterwardle::tools
}