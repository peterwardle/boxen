class people::peterwardle::applications::atom {

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
}
