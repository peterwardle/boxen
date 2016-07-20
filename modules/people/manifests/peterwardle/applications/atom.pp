class people::peterwardle::applications::atom {

    define atompackage {
        exec { "Atom:${title}":
            unless => 'apm list | grep file-icons',
            command => 'apm install file-icons',
            require => Package['atom'],
        }
    }

    atompackage { [
            'autocomplete-plus',
            # 'autocomplete-php',
            'highlight-selected',
            'file-icons',
        ]:
    }

    atompackage { 'autocomplete-php':
        require => Atompackage['autocomplete-plus'],
    }
}
