define dotNet::wic(
  $version = $title,
  $source  = undef
) {

  if $source {
    $location = $source

  } else {
    $exe_name = "wic_${architecture}_enu.exe"
    $location = "puppet:///modules/${module_name}/${exe_name}"
  }

  package { "Windows Imaging Component":
    ensure => installed,
    source => $location,
  }
}
