# puppet scrit
exec { 'install_nginx_and_configure_header':
  command  => 'apt-get -y update && apt-get -y install nginx',
  path     => '/usr/bin',
  creates  => '/etc/nginx/sites-available/default',
  notify   => Exec['add_custom_header'],
}

exec { 'add_custom_header':
  command  => '/bin/sed -i "/listen 80 default_server;/a add_header X-Served-By ${hostname};" /etc/nginx/sites-available/default',
  path     => '/bin',
  refreshonly => true,
  subscribe => Exec['install_nginx_and_configure_header'],
  require  => Class['nginx'],
}

service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Class['nginx'],
}

