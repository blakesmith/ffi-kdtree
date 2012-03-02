require 'mkmf'

dir = File.expand_path(File.dirname(__FILE__))
find_header('kdtree.h', dir)
create_makefile('ffi-kdtree/kdtree')
