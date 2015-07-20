class syncthing::setup {
    case $operatingsystem {
        'Ubuntu': {
            case $lsbdistcodename {
                'trusty', 'precise': {
                    exec {"syncthing_add_pgp_keys":
                        path => [ "/bin", "/usr/bin", "/usr/local/bin" ],
                        command => "curl -s https://syncthing.net/release-key.txt | sudo apt-key add -",
                    }
                    exec {"syncthing_add_release_channel":
                        path => [ "/bin", "/usr/bin", "/usr/local/bin" ],
                        command => "echo deb http://apt.syncthing.net/ syncthing release | sudo tee /etc/apt/sources.list.d/syncthing-release.list"
                    }
                    exec {"syncthing_apt_update":
                        path => [ "/bin", "/usr/bin", "/usr/local/bin" ],
                        command => "sudo apt-get update",
                    }
                    package {"syncthing":
                        ensure => 'installed',
                    }
                    Exec["syncthing_add_pgp_keys"]->
                    Exec["syncthing_add_release_channel"]->
                    Exec["syncthing_apt_update"]->
                    Package["syncthing"]
                }
            }
        }
    }
}
