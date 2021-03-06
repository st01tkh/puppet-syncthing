define syncthing_user_upstart($username=$id){
  $home = "home_$username"
  $home_path = inline_template("<%= scope.lookupvar('::$home') %>")
  $conf_path = "$home_path/.config/upstart/syncthing.conf"
  notify{"Syncthing upstart config path: $conf_path":}
  file{"$conf_path":
    mode    => '0755',
    content => template('syncthing/syncthing.conf.erb'),
  }
}

class syncthing::start{
  case $operatingsystem {
  'Solaris':          {
    notify {'No action for Solaris yet':}
  }
  'RedHat', 'CentOS': {
    notify {'No action for RedHat and/or CentOS yet':} 
  }
  /^(Ubuntu)$/:{
    case $lsbdistcodename {
    'precise': {
    }
    'trusty': {
	syncthing_user_upstart{'syncthing_user_upstart_rsc': }
    }
    }
  }
  /^(Debian)$/:{
    notify {'No action for Debian yet':}
  }
  default: {
    notify {'No action by default':}
  }
  }

}
