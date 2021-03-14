require 'find'

def finds(path)
    files = []
    Find.find(path) do |f|
        if (File.file?(f) && File.stat(f).setuid? && File.executable?(f))
            files << file
        end
    rescue
        next
    end
    files
end

puts finds('/')
