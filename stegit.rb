#
#hide file2 in file1 but its in file3
##################
unless ARGV[0]
    puts "3 args needed"
    puts "eg:image.png datahide.pdf outimage.png"
end

file1, file2, file3 = ARGV
origfile = File.read(file1)
datafile = File.read(file2)
sep_line = "|----------#{file2}------------|"
output = [origfile, sep_line, datafile]

File.open(file3, 'wb') do |x|
    output.each do |f|
        x.puts f
    end
end
