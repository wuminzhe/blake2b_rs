require "blake2b/version"
require 'ffi'

module Blake2b
  class Error < StandardError; end

  extend FFI::Library
  ffi_lib "target/debug/libblake2b." + FFI::Platform::LIBSUFFIX
  attach_function :rust_blake2b, %i[pointer int int], :string

  def self.hex(u8a, out_len=32)
    c = FFI::MemoryPointer.new(:int8, u8a.size)
    c.write_array_of_int8 u8a

    self.rust_blake2b(c, c.size, out_len)
  end
end
