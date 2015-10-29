class people::peterwardle::tools {
    
    homebrew::tap { 'homebrew/php': }

    package {
        [
            'go',
            'node',
            'jq',
            'phantomjs',
            'ngrep',
            'goaccess',
            'watch',
            'git-flow',
            'wget'
        ]:
    }

    package {
        [
            'homebrew/php/composer',
            'homebrew/php/php-cs-fixer',
            'homebrew/php/php-code-sniffer'
        ]:
        install_options => ['--ignore-dependencies']
    }
}