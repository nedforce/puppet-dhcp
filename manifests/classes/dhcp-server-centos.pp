class dhcp::server::centos inherits dhcp::server::base {

  Common::Concatfilepart["00.dhcp.server.base"] {
    content => template('dhcp/dhcpd.conf.centos.erb'),
  }
  
  file { "/etc/sysconfig/dhcpd":
    require => Package["dhcp-server"],
    ensure  => present,
    source => "puppet:///modules/dhcp/dhcpd_sysconfig",
  }  

  file { "/var/lib/dhcpd/dhcpd.leases":
    ensure => present,
  }
  
  Service["dhcpd"] {
    name    => "dhcpd",
    require => File["/var/lib/dhcpd/dhcpd.leases"],
  }
  

  
}
