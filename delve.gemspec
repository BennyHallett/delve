Gem::Specification.new do |g|
  g.name        = 'delve'
  g.version     = '0.0.2'
  g.date        = '2014-02-01'
  g.summary     = 'Roguelike library inspired by rot.js and libtcod'
  g.description = 'Roguelike library inspired by rot.js and libtcod'
  g.authors     = ['Benny Hallett']
  g.files       = [
                    'lib/delve/event_queue.rb',
                    'lib/delve/game.rb',
                    'lib/delve/screen_manager.rb',
                    'lib/delve/display/display.rb',
                    'lib/delve/display/curses_renderer.rb',
                    'lib/delve/scheduler/scheduler.rb',
                    'lib/delve/widgets/text.rb'
                  ]
  g.homepage    = 'http://bennyhallett.com/delve'
  g.license    = 'BSD'
  g.add_development_dependency('rake')
  g.add_development_dependency('minitest')
  g.add_development_dependency('mocha')
  g.add_runtime_dependency('perlin_noise')
end
