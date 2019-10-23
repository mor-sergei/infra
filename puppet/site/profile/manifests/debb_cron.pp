# Cron management manifest wraper around Puppet cron 
# $condition = 'present'/'absent'
# You could add your variables here - but do not forget to set deffault value!

class profile::debb_cron ( $job_hour = [0, 12], $job_minute = 0, $job_user = 'root', $command = 'echo [Test] job', $condition = 'present' ){
  cron { 'job_creator':
    ensure      => $condition,
    environment => 'PATH=/bin:/usr/bin:/usr/sbin',
    command     => $command,
    user        => $job_user,
    hour        => $job_hour,
    minute      => $job_minute,
  }
}