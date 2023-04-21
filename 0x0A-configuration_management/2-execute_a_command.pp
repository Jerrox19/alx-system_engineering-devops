# This manifest kills a process named 'killmenow' using pkill

exec { 'kill-killmenow':
  command => '/usr/bin/pkill -f killmenow',
  onlyif  => '/usr/bin/pgrep -f killmenow',
}

