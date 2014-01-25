Gem::Specification.new do |g|
  g.name        = 'delve'
  g.version     = '0.0.1'
  g.date        = '2014-01-25'
  g.summary     = 'Roguelike library inspired by rot.js and libtcod'
  g.description = 'Roguelike library inspired by rot.js and libtcod'
  g.authors     = ['Benny Hallett']
  g.files       = ['lib/delve.rb']
  g.homepage    = 'http://bennyhallett.com/delve'
  g.license    = 'BSD'
  g.add_development_dependency('rake')
  g.add_development_dependency('mocha')
  #s.add_runtime_dependency('gli','2.8.1')
end
