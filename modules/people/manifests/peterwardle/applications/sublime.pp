class people::peterwardle::applications::sublime {

    $sublime_directory = "/Users/${::boxen_user}/Library/Application Support/Sublime Text 3/"
    $sublime_package_directory = "${sublime_directory}/Packages"

    package { 'Sublime Text':
        ensure   => installed,
        source   => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203083.dmg',
        provider => appdmg,
    }

    file { 'Add Sublime Text Cli to Path':
        path    => '/usr/local/bin/subl',
        ensure  => link,
        target  => '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl',
        require => Package['Sublime Text'],
    }

    exec { 'Create Sublime Text Icon Resource':
        command => 'curl -sLo Sublime-Text-Icons.zip "https://dribbble.com/shots/2104476-Material-Theme-for-Sublime-Text-3/attachments/380650" && unzip -p Sublime-Text-Icons.zip Icon.png > Sublime-Text-Icon.png && sips -i Sublime-Text-Icon.png && DeRez -only icns Sublime-Text-Icon.png > Sublime-Text-Icon.rsrc',
        cwd     => '/tmp',
    }

    exec { 'Set Sublime Text Icon':
        command => 'Rez -append Sublime-Text-Icon.rsrc -o $\'/Applications/Sublime Text.app/Icon\r\' && SetFile -a C "/Applications/Sublime Text.app"',
        cwd     => '/tmp',
        require => [Package['Sublime Text'], Exec['Create Sublime Text Icon Resource']],
    }

    exec { 'Subl: Package Control':
        creates => "${sublime_directory}/Installed Packages/Package Control.sublime-package",
        command => "curl -sLo '${sublime_directory}/Installed Packages/Package Control.sublime-package' 'https://packagecontrol.io/Package%20Control.sublime-package' &> /dev/null",
        require => Package['Sublime Text'],
    }

    exec { 'Subl: SublimePuppet':
        creates => "${sublime_package_directory}/SublimePuppet",
        command => "curl -sLo /tmp/SublimePuppet.zip 'https://github.com/russCloak/SublimePuppet/archive/master.zip' && unzip /tmp/SublimePuppet.zip -d /tmp && mv /tmp/SublimePuppet-master '${sublime_package_directory}/SublimePuppet'",
        require => Package['Sublime Text'],
    }

    repository { "${sublime_package_directory}/Material Theme":
        source  => 'equinusocio/material-theme',
        require => Package['Sublime Text'],
    }

    file { "${sublime_package_directory}/User/Preferences.sublime-settings":
        ensure  => link,
        target  => "${::boxen_srcdir}/appconfig/sublime-text/Preferences.sublime-settings",
        require => [Repository["${::boxen_srcdir}/appconfig"], Repository["${sublime_package_directory}/Material Theme"]],
    }

    # Phpcs
    repository { "${sublime_package_directory}/Phpcs":
        source  => 'benmatselby/sublime-phpcs',
        require => [Package['Sublime Text'], Exec['/usr/local/bin/phpcs'], Exec['/usr/local/bin/php-cs-fixer']],
    }

    file { "${sublime_package_directory}/User/phpcs.sublime-settings":
        ensure  => link,
        target  => "${::boxen_srcdir}/appconfig/sublime-text/phpcs.sublime-settings",
        require => [Repository["${::boxen_srcdir}/appconfig"], Repository["${sublime_package_directory}/Phpcs"]],
    }

    exec { '/usr/local/bin/phpcs':
        creates => '/usr/local/bin/phpcs',
        command => 'curl -sLo /usr/local/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && chmod +x /usr/local/bin/phpcs',
    }

    exec { '/usr/local/bin/php-cs-fixer':
        creates => '/usr/local/bin/php-cs-fixer',
        command => 'curl -sLo /usr/local/bin/php-cs-fixer http://get.sensiolabs.org/php-cs-fixer.phar && chmod +x /usr/local/bin/php-cs-fixer',
    }

    # SublimeCodeIntel
    repository { "${sublime_package_directory}/SublimeCodeIntel":
        ensure  => 'v2.2.0+st3',
        source  => 'SublimeCodeIntel/SublimeCodeIntel',
        require => Package['Sublime Text'],
    }

    file { "${sublime_package_directory}/User/SublimeCodeIntel.sublime-settings":
        ensure  => link,
        target  => "${::boxen_srcdir}/appconfig/sublime-text/SublimeCodeIntel.sublime-settings",
        require => [Repository["${::boxen_srcdir}/appconfig"], Repository["${sublime_package_directory}/SublimeCodeIntel"]],
    }
}