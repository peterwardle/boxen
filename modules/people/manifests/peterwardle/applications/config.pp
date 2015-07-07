class people::peterwardle::applications::config {

    repository { 'src/appconfig':
        path   => "${::boxen_srcdir}/appconfig",
        source => 'git@bitbucket.org:peterwardle/appconfig.git'
    }
}