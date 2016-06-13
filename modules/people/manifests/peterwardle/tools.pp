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
            'wget',
            'coreutils',
            'findutils',
            'tree'
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

    # exec { 'install Google Cloud SDK':
    #     unless  => 'gcloud -v &> /dev/null',
    #     command => 'curl https://sdk.cloud.google.com | bash && exec -l $SHELL && gcloud init',
    # }

    # exec { 'install kubectrl':
    #     command => 'gcloud components install kubectl',
    #     require => Exec['install Google Cloud SDK'],
    # }
}