worker_processes 2 # Usually set to 1.5 * number_of_cpu_cores
listen 3000
pid 'tmp/pids/unicorn.pid'

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true
timeout 30

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
