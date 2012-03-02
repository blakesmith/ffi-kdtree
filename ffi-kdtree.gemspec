# -*- encoding: utf-8 -*-
#
Gem::Specification.new do |s|
  s.name        = "ffi-kdtree"
  s.version     = "0.0.1"
  s.authors     = ["Scott Deming"]
  s.email       = ["sdeming@makefile.com"]
  s.homepage    = "https://github.com/sdeming/ffi-kdtree"
  s.summary     = %q{This is a simple FFI wrapped version of libkdtree for Ruby}
  s.description = %q{This is a simple FFI wrapped version of libkdtree for Ruby. 
  It's a pure ruby wrapper so this gem can be loaded and run by any ruby runtime 
  that supports FFI. That's all of them: MRI 1.9.x, Rubinius and JRuby.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
#  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.extensions = ['ext/ffi-kdtree/extconf.rb']

  s.add_runtime_dependency "ffi"#, [">= 1.0.9"]
  s.add_development_dependency "rspec", ["~> 2.6"]
  s.add_development_dependency "rake"
end
