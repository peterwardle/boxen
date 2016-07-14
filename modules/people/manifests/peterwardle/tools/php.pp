class people::peterwardle::tools::php {
    
    package { 'php-cs-fixer':
        name => 'friendsofphp/php-cs-fixer',
        provider => 'composer',
    }

    package { 'php-code-sniffer':
        name => 'gamegos/php-code-sniffer',
        provider => 'composer',
    }
}
