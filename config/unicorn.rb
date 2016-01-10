
@dir = "/home/centos/unicorn/"

worker_processes 2 # CPUのコア数に揃える
working_directory @dir

timeout 300
#listen "/home/centos/unicorn/tmp/unicorn.sock"
listen 3000

pid "#{@dir}tmp/pids/unicorn.pid" #pidを保存するファイル

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end


# unicornは標準出力には何も吐かないのでログ出力を忘れずに
stderr_path "#{@dir}log/unicorn.stderr.log"
stdout_path "#{@dir}log/unicorn.stdout.log"
