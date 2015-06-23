class projects::drummondcentral {

    $applications = [
        'adobe-air'
    ]

    package { $applications:
        provider => 'brewcask',
    }

    exec { 'download traffic':
        unless  => 'test -d /Applications/Traffic.app',
        creates => '/tmp/TrafficApplication-Installer.air',
        command => 'curl -so /tmp/TrafficApplication-Installer.air "http://traffic-live-dist.s3.amazonaws.com/TrafficApplication-Installer.air"',
    }

    exec { 'install traffic':
        creates => '/Applications/Traffic.app',
        command => '"/Applications/Utilities/Adobe AIR Application Installer.app/Contents/MacOS/Adobe AIR Application Installer" -silent /tmp/TrafficApplication-Installer.air',
        require => [Exec['download traffic'], Package['adobe-air']],
    }
}