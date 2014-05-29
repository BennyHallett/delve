Gem::Specification.new do |g|
  g.name        = 'delve'
  g.version     = '0.0.7'
  g.date        = '2014-03-24'
  g.summary     = 'Roguelike library inspired by rot.js and libtcod'
  g.description = 'Roguelike library inspired by rot.js and libtcod. Allows developers to get a jumpstart on their roguelike development, by running a single command to get started with an "@ walking around the world" demo.'
  g.authors     = ['Benny Hallett']
  g.files       = `git ls-files`.split($/)
  g.bindir      = 'bin'
  g.executables << 'delve'
  g.homepage    = 'https://github.com/BennyHallett/delve'
  g.license     = 'BSD'
  g.add_development_dependency('rake', '10.1.1')
  g.add_development_dependency('minitest', '5.2.2')
  g.add_development_dependency('mocha', '1.0.0')
  g.add_runtime_dependency('perlin_noise', '0.1.2')
end
