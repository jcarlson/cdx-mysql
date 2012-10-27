define mysql::db($ensure = present) {
  require mysql

  if $ensure == 'present' {
    exec { "mysql-db-${name}":
      command => "mysqladmin -uroot create ${name}",
      creates => "${mysql::config::datadir}/${name}",
      require => Exec['wait-for-mysql']
    }
  } elsif $ensure == 'absent' {
    exec { "delete-mysql-db-${name}":
      command => "mysqladmin -uroot drop database ${name}",
      require => Exec['wait-for-mysql']
    }
  }
}
