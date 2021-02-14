# set lets
$worker  = 2
$timeout = 30
$app_dir = "/var/www/projects/rails-test"
$listen  = File.expand_path 'shared/tmp/sockets/.unicorn.sock', $app_dir
$pid     = File.expand_path 'shared/tmp/pids/unicorn.pid', $app_dir
$std_log = File.expand_path 'shared/log', $app_dir
# set config
worker_processes  $worker
working_directory "#{$app_dir}/current"
stderr_path "#{$std_log}/unicorn.stderr.log"
stdout_path "#{$std_log}/unicorn.stdout.log"
timeout $timeout
listen  $listen
pid $pid
# loading booster
preload_app true
# before starting processes
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end
# after finishing processes
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end

