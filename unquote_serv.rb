#find stuff for fun
#
##########################
require 'win32ole'

wmi = WIN32OLE.connect("winmgmts://")
ps = wmi.ExecQuery("Select * from Win32_Service where StartMode = 'Auto'")

vuln_servs = ps.each.select do |s|
    path = s.pathname.match(/.*\.exe).to_s
    path.include?(' ') && !(path.start_with?('"') && path.end_with?('"')) && File.writable?(path)
end

puts "[+] Vulnerable unquoted service found: #{vuln_servs.size}"
puts vuln_servs.map(&:pathname)