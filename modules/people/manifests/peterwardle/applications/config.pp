class people::peterwardle::applications::config {

    repository { "${::boxen_srcdir}/appconfig":
        source => 'git@bitbucket.org:peterwardle/appconfig.git'
    }
}