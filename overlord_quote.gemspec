
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "overlord_quote/version"

Gem::Specification.new do |spec|
  spec.name          = "overlord_quote"
  spec.license       = "MIT"
  spec.version       = OverlordQuote::VERSION
  spec.authors       = ["Dmitry Maksyoma"]
  spec.email         = ["ledestin@gmail.com"]

  spec.summary       = %q{to-do: Write a short summary, because RubyGems requires one.}
  spec.description   = %q{to-do: Write a longer description or delete this line.}


  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "to-do: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = "overlord_quote"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency('rdoc')
  spec.add_development_dependency('test-unit')
  spec.add_development_dependency('rspec', '~> 3')

  spec.add_dependency('methadone', '~> 2.0.0')
  spec.add_dependency('activesupport')
end
