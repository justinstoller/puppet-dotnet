class dotnet::wic(
  $version     = $title,
  $source      = undef,
  $destination = 'C:\packages',
) {

  $exe_name = "wic_${architecture}_enu.exe"

  if $source {
    $location = $source
  } else {
    $location = "puppet:///modules/${module_name}/${exe_name}"
  }

  $on_disk = "${destination}\\${exe_name}"

  file { $on_disk:
    ensure => file,
    source => $location,
    mode   => '750',
  }

  # 'Windows Imaging Component' is installed as an update, not a full package
  exec { "${on_disk} /q /norestart":
    require => File[$on_disk],
    creates => "${systemroot}\\system32\\windowscodecs.dll"
  }
}
