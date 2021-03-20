#!/usr/bin/env ruby
#
#Simulate a Linux /etc/shadow stored password
###################
require 'digest/sha2'

def prompt(*args)
  print(*args)
  gets
end

def saltPass(password)
  salt = rand(36**8).to_s(36)
  hash = Digest::SHA2.hexdigest(password + salt)
end

unless ARGV[0]
  password = prompt "#:/ "
else
  password = ARGV[0]
end

hashedPass = saltPass(password)
puts hashedPass


###################