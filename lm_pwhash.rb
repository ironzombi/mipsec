#!/usr/bin/env ruby
#
#code snippet from RubyNTLM gem
#code is not useful
###################
require 'openssl'

def split7(str)
  str.scan(/.{1,7}/)
end

def gen_key(str)
  split7(str).map do |str7|
    bits = split7(str7.unpack("B*")[0]).inject('') do |ret, tkn|
      ret += tkn + (tkn.gsub('1', '').size % 2).to_s
    end
    [bits].pack("B*")
  end
end

def add_des(plain, keys)
  des = OpenSSL::Cipher::DES.new
  keys.map do |key|
    des.key = key
    des.encrypt
    #initially 'des.encrypt.update(plain)' errors 
    #des.update(plain)
  end
end

def lm_hash(password)
  lmmagic = "KGS!@\#$%"
  keys    = gen_key(password.upcase[0,13].ljust(14, "\0"))
  add_des(lmmagic, keys).join
end

password = "Password01"
key = ["\xBA\xBC\xE5\x19\x19\xB9\xA9\x19"]
lmagic = "KGS!@\#$%"

add_des(lmagic, key)

lm_hash(password)
