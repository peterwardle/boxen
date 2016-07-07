class people::peterwardle::applications::sublime {

    $sublime_app_directory = "/Applications/Sublime Text.app"
    #$sublime_app_directory = "/Users/${::boxen_user}/Applications/Sublime Text.app"
    $sublime_lib_directory = "/Users/${::boxen_user}/Library/Application Support/Sublime Text 3"
    $sublime_package_directory = "${sublime_lib_directory}/Packages"

    file { 'Add Sublime Text Cli to Path':
        ensure  => link,
        path    => '/usr/local/bin/subl',
        target  => "${sublime_app_directory}/Contents/SharedSupport/bin/subl",
        require => Package['sublime-text'],
    }

    exec { 'Create Sublime Text Icon Resource':
        unless  => "test -e \$'${sublime_app_directory}/Icon\r'",
        command => 'curl -sLo Sublime-Text-Icons.zip "https://dribbble.com/shots/2104476-Material-Theme-for-Sublime-Text-3/attachments/380650" && unzip -p Sublime-Text-Icons.zip Icon.png > Sublime-Text-Icon.png && sips -i Sublime-Text-Icon.png && DeRez -only icns Sublime-Text-Icon.png > Sublime-Text-Icon.rsrc',
        cwd     => '/tmp',
    }

    exec { 'Set Sublime Text Icon':
        unless  => "test -e \$'${sublime_app_directory}/Icon\r'",
        command => "Rez -append Sublime-Text-Icon.rsrc -o \$'${sublime_app_directory}/Icon\r' && SetFile -a C '${sublime_app_directory}'",
        cwd     => '/tmp',
        require => [Package['sublime-text'], Exec['Create Sublime Text Icon Resource']],
    }

    exec { 'Subl: Package Control':
        creates => "${sublime_lib_directory}/Packages/Package Control.sublime-package",
        command => "curl -sLo '${sublime_lib_directory}/Packages/Package Control.sublime-package' 'https://packagecontrol.io/Package%20Control.sublime-package' &> /dev/null",
        require => Package['sublime-text'],
    }

    exec { 'Subl: SublimePuppet':
        creates => "${sublime_package_directory}/SublimePuppet",
        command => "curl -sLo /tmp/SublimePuppet.zip 'https://github.com/russCloak/SublimePuppet/archive/master.zip' && unzip /tmp/SublimePuppet.zip -d /tmp && mv /tmp/SublimePuppet-master '${sublime_package_directory}/SublimePuppet'",
        require => Package['sublime-text'],
    }

    repository { "${sublime_package_directory}/Material Theme":
        path    => "${sublime_package_directory}/Material Theme",
        source  => 'equinusocio/material-theme',
        require => Package['sublime-text'],
    }

    repository { "${sublime_package_directory}/Phpcs":
        path    => "${sublime_package_directory}/Phpcs",
        source  => 'benmatselby/sublime-phpcs',
        require => [Package['sublime-text'], Package['homebrew/php/php-code-sniffer'], Package['homebrew/php/php-cs-fixer']],
    }

    repository { "${sublime_package_directory}/SublimeCodeIntel":
        ensure  => 'v2.2.0+st3',
        path    => "${sublime_package_directory}/SublimeCodeIntel",
        source  => 'SublimeCodeIntel/SublimeCodeIntel',
        require => Package['sublime-text'],
    }

    symlink { [
            'Package Control.sublime-settings',
            'Preferences.sublime-settings',
            'SublimeCodeIntel.sublime-settings',
            'phpcs.sublime-settings'
        ]:
        source_dir => "${::boxen_srcdir}/appconfig/sublime-text",
        destination_dir => "${sublime_package_directory}/User",
    }
}
