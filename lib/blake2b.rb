require "blake2b/version"
require 'ffi'

class Str < FFI::AutoPointer
  def self.release(ptr)
    Blake2b.free(ptr)
  end

  def to_s
    @str ||= self.read_string.force_encoding('UTF-8')
  end
end

module Blake2b
  class Error < StandardError; end

  extend FFI::Library
  ffi_lib "#{__dir__}/../target/release/libblake2b." + FFI::Platform::LIBSUFFIX
  attach_function :rust_blake2b, %i[pointer int int], Str
  attach_function :free, :free_s, [Str], :void

  def self.hex(u8a, out_len=32)
    c = FFI::MemoryPointer.new(:int8, u8a.size)
    c.write_array_of_int8 u8a

    self.rust_blake2b(c, c.size, out_len).to_s
  end

  def self.blake2b160(u8a)
    self.hex(u8a, 20)
  end

  def self.blake2b256(u8a)
    self.hex(u8a, 32)
  end

  def self.blake2b512(u8a)
    self.hex(u8a, 64)
  end
end
