define dotNet::installation(
  $version = $title,
  $source  = undef
) {

  if $source {
    $location = $source

  } else {
    $exe_name = "dotnetfx${version}_full_x86_x64.exe"
    $location = "puppet:///modules/${module_name}/${exe_name}"
  }

  package { "dotNet-${version}":
    ensure => installed,
    source => $location,
  }
}
