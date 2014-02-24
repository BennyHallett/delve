#!/usr/bin/env ruby
require 'delve/display/curses_renderer'
require 'delve/display/curses_renderer'
require 'delve/display/display'
require 'delve/input/input'
require 'delve/input/curses_input'
require 'delve/screen_manager'
require 'delve/game'

require 'ttt/screens/title'

display = Display.new CursesRenderer.new
screen_manager = ScreenManager.new
title_screen = TitleScreen.new screen_manager
screen_manager.push_screen title_screen
input = Input.new CursesInput.new

game = Game.new display, screen_manager, input
game.start

display.exit
