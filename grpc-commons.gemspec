# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grpc/client/commons/version'

Gem::Specification.new do |spec|
  spec.name          = "grpc-commons"
  spec.version       = 0.1
  spec.authors       = ["Shiladitya Mandal"]
  spec.email         = ["16.shiladitya@gmail.com"]

  spec.summary       = "Set of tools both on gRPC client & server side"
  spec.description   = "Set of tools both on gRPC client & server side"
  spec.homepage      = "shiladitya-bits.github.io"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "grpc"
  spec.add_dependency "stoplight"
  spec.add_dependency "statsd-instrument"
end
