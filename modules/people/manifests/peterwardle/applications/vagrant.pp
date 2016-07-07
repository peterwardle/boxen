class people::peterwardle::applications::vagrant {
   # exec { 'install vagrant-cachier':
   #     unless  => 'vagrant plugin list | grep vagrant-cachier &> /dev/null',
   #     command => 'vagrant plugin install vagrant-cachier',
   #     require => Package['vagrant'],
   # }
}
