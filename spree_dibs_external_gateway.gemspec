# Maintain your gem's version:
version = File.read(File.expand_path("../version",__FILE__)).strip

Gem::Specification.new do |s|
  s.name        = "spree_dibs_external_gateway"
  s.version     = version
  s.author     = "Erik Axel Nielsen"
  s.email       = "spree@illumina.no"
  s.homepage    = "https://github.com/erikaxel/spree_dibs_external_gateway"
  s.summary     = "N/A"
  s.description = "N/A"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = %w(lib)
  s.has_rdoc      = false

  s.add_dependency 'spree_core', '>=1.3.0'
end
