#!/usr/bin/env ruby
require 'blinkt'

set_clear_on_exit

step = 0

loop do
  if step.zero?
    set_all(128, 0, 0)
  elsif step == 1
    set_all(0, 128, 0)
  elsif step == 2
    set_all(0, 0, 128)
  end

  step += 1
  step %= 3
  show
  sleep(0.5)
end
