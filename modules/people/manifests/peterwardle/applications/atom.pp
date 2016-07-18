class people::peterwardle::applications::atom {
    exec { 'Install:autocomplete-plus':
        command => 'apm install autocomplete-plus',
        require => Package['atom'],
    }

    exec { 'Install:autocomplete-php':
        command => 'apm install autocomplete-php',
        require => Exec['Install:autocomplete-plus'],
    }
}
