###############
#windows remote management:winrm
# ./winrm.rb <command>
##
require 'winrm'

cmd = ARGV[0]

opts = {
  endpoint: 'http://192.168.1.1:5985/wsman',
  transport: :negotiate,
  user: 'administrator',
  password: 'password1'
}

conn = WinRM::Connection.new(opts)
conn.shell(:powershell) do |shell|
  output = shell.run(cmd) do |stdout, stderr|
    puts stdout
    puts stderr
  end
  puts "exit code:#{output.exitcode}"
end
