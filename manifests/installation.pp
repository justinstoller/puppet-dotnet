define dotnet::installation(
  $version     = $title,
  $source      = undef,
  $destination = 'C:\packages'
) {

  if $source {
    $location = $source

  } else {
    $exe_name = "dotnetfx${version}_full_x86_x64.exe"
    $location = "puppet:///modules/${module_name}/${exe_name}"
  }

  $on_disk = "${destination}\\dotnetfx.exe"

  file { $on_disk:
    ensure => file,
    source => $location,
    mode   => '750',
  }

  package { 'Microsoft .NET Framework 4.5':
    ensure => present,
    source => $on_disk,
    install_options => [ '/q', '/norestart' ],
  }
}
