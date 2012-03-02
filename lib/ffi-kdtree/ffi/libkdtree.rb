require 'ffi'

module LibKdTree
  extend FFI::Library

  begin
    # bias the library discovery to a path inside the gem first, then
    # to the usual system paths
    inside_gem = File.join(File.dirname(__FILE__), '..')
    KDTREE_LIB_PATHS = [
    inside_gem, '/usr/local/lib', '/opt/local/lib', '/usr/local/homebrew/lib', '/usr/lib64'
    ].map{|path| "#{path}/kdtree.#{RbConfig::CONFIG['DLEXT']}"}
    ffi_lib(KDTREE_LIB_PATHS + %w{kdtree})
  rescue LoadError
    STDERR.puts "Unable to load this gem. The kdtree library (or DLL) could not be found."
    STDERR.puts "If this is a Windows platform, make sure kdtree.dll is on the PATH."
    STDERR.puts "For non-Windows platforms, make sure kdree is located in this search path:"
    STDERR.puts KDTREE_LIB_PATHS.inspect
    exit 255
  end

  callback :kd_data_destructor_callback, [:pointer], :void

  class HyperRect < FFI::Struct
    layout :dim, :int,
           :min, :pointer,
           :max, :pointer
  end

  class Node < FFI::Struct
    layout :pos,   :pointer,
           :dir,   :int,
           :data,  :pointer,
           :left,  :pointer,
           :right, :pointer
  end

  class ResNode < FFI::Struct
    layout :item,    :pointer,
           :dist_sq, :double,
           :next,    :pointer
  end

  class Tree < FFI::Struct
    layout :dim,   :int,
           :root,  :pointer,
           :rect,  :pointer,
           :destr, :kd_data_destructor_callback
  end

  class Res < FFI::Struct
    layout :tree,  :pointer,
           :rlist, :pointer,
           :riter, :pointer,
           :size,  :int
  end

  attach_function :kd_create, [:int], :pointer
  attach_function :kd_free, [:pointer], :void
  attach_function :kd_clear, [:pointer], :void
  attach_function :kd_data_destructor, [:pointer, :kd_data_destructor_callback], :void 

  attach_function :kd_insert, [:pointer, :pointer, :pointer], :int
  attach_function :kd_nearest, [:pointer, :pointer], :pointer
  attach_function :kd_nearest_range, [:pointer, :pointer, :double], :pointer

  attach_function :kd_res_free, [:pointer], :void
  attach_function :kd_res_size, [:pointer], :int
  attach_function :kd_res_rewind, [:pointer], :void
  attach_function :kd_res_end, [:pointer], :int
  attach_function :kd_res_next, [:pointer], :int
  attach_function :kd_res_item, [:pointer, :pointer], :pointer
  attach_function :kd_res_item_data, [:pointer], :pointer
end
