class people::peterwardle::applications::atom {

    $atom_config_directory = "/Users/${::boxen_user}/.atom"

    define atompackage {
        exec { "Atom:${title}":
            unless => "apm list | grep ${title}",
            command => "apm install ${title}",
            require => Package['atom'],
        }
    }

    atompackage { [
            'autocomplete-plus',
            # 'autocomplete-php',
            'highlight-selected',
            'file-icons',
            'docblockr',
        ]:
    }

    atompackage { 'autocomplete-php':
        require => Atompackage['autocomplete-plus'],
    }
    atompackage { 'php-cs-fixer':
        require => Package['php-cs-fixer'],
    }

    symlink { [
            'config.cson'
        ]:
        source_dir => "${::boxen_srcdir}/appconfig/atom",
        destination_dir => "${atom_config_directory}",
    }
}
