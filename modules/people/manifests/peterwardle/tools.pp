class people::peterwardle::tools {

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
            'tree',
            'httpstat',
            'httpie'
        ]:
    }

    include people::peterwardle::tools::php
}
