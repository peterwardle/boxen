class people::peterwardle::applications::atom {
    exec { 'Atom:autocomplete-plus':
        unless => 'apm list | grep autocomplete-plus',
        command => 'apm install autocomplete-plus',
        require => Package['atom'],
    }

    exec { 'Atom:autocomplete-php':
        unless => 'apm list | grep autocomplete-php',
        command => 'apm install autocomplete-php',
        require => Exec['Atom:autocomplete-plus'],
    }
}
