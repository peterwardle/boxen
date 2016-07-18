class people::peterwardle::applications::atom {
    # # The autocomplete-plus package is bundled with Atom and should not be explicitly installed.
    # exec { 'Atom:autocomplete-plus':
    #     command => 'apm install autocomplete-plus',
    #     require => Package['atom'],
    # }

    exec { 'Atom:autocomplete-php':
        unless => 'apm list | grep autocomplete-php',
        command => 'apm install autocomplete-php',
        # require => Exec['Atom:autocomplete-plus'],
    }
}
