#!/usr/bin/env ruby
require 'blinkt'
# Math module is required if using Sine wave example
# require 'math'

set_clear_on_exit

reds = [0, 0, 0, 0, 0, 16, 64, 255, 64, 16, 0, 0, 0, 0, 0]

start_time = Time.now.to_f

loop do
  now = Time.now.to_f
  delta = (now - start_time) * 16
  # Sine wave, spends a little longer at min/max
  # offset = (((Math.sin(delta) + 1) / 2) * 7).round.to_i

  # Triangle wave, a snappy ping-pong effect
  offset = ((delta % 16) - 8).abs.to_i

  (0..7).each do |i|
    set_pixel(i, reds[offset + i], 0, 0)
  end
  show

  sleep(0.1)
end
