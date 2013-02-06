# == Class: dotnet
#
# Full description of class dotnet here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { dotnet:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class dotnet(
  $version     = undef,
  $source      = undef,
  $destination = 'C:\packages'
) {

  $is_old = $::kernelmajversion =~ /^5\./

  if $version {
    $ver = $version
  } elsif $title != 'dotnet' {
    $ver = $title
  } elsif $is_old {
    $ver = '40'
  } else {
    $ver = '45'
  }


  if $is_old and $ver == '4.5' {
    crit('.NET 4.5 only supports Windows 7, 8, Server2008, and Server2012.')
    fail()
  }

  if $is_old {
    require dotnet::wic
  }

  dotnet::installation { $ver:
    source      => $source,
    destination => $destination,
  }

}
