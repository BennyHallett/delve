Gem::Specification.new do |g|
  g.name        = 'delve'
  g.version     = '0.0.3'
  g.date        = '2014-02-09'
  g.summary     = 'Roguelike library inspired by rot.js and libtcod'
  g.description = 'Roguelike library inspired by rot.js and libtcod'
  g.authors     = ['Benny Hallett']
  g.files       = `git ls-files`.split($/)
  g.homepage    = 'http://bennyhallett.com/delve'
  g.license    = 'BSD'
  g.add_development_dependency('rake')
  g.add_development_dependency('minitest')
  g.add_development_dependency('mocha')
  g.add_runtime_dependency('perlin_noise')
end
