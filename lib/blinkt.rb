# Ported from the Pimoroni Blinkt Python library
# - https://github.com/pimoroni/blinkt

require 'rpi_gpio'

DAT = 23
CLK = 24
NUM_PIXELS = 8
BRIGHTNESS = 7

$pixels = [[0, 0, 0, BRIGHTNESS]] * 8

$_gpio_setup = false
$_clear_on_exit = true

# Set the brightness of all pixels
# Params:
# +brightness+:: Brightness: 0.0 to 1.0
def set_brightness(brightness)
  (0..NUM_PIXELS - 1).each do |x|
    $pixels[x][3] = (31.0 * brightness).to_i & 0b11111
  end
end

# Clear the pixel buffer
def clear
  (0..(NUM_PIXELS - 1)).each do |x|
    $pixels[x][0..2] = [0, 0, 0]
  end
end

def _write_byte(byte)
  (0..7).each do |_x|
    if byte & 0b10000000 > 0
      RPi::GPIO.set_high DAT
    else
      RPi::GPIO.set_low DAT
    end
    RPi::GPIO.set_high CLK
    byte <<= 1
    RPi::GPIO.set_low CLK
  end
end

# Emit exactly enough clock pulses to latch the small dark die APA102s which are weird
# for some reason it takes 36 clocks, the other IC takes just 4 (number of pixels/2)
def _eof
  RPi::GPIO.set_low DAT
  (0..35).each do |_x|
    RPi::GPIO.set_high CLK
    RPi::GPIO.set_low CLK
  end
end

def _sof
  RPi::GPIO.set_low DAT
  (0..31).each do |_x|
    RPi::GPIO.set_high CLK
    RPi::GPIO.set_low CLK
  end
end

# Output the buffer to Blinkt!
def show
  unless $_gpio_setup
    RPi::GPIO.set_numbering :bcm
    RPi::GPIO.set_warnings true
    RPi::GPIO.setup DAT, as: :output
    RPi::GPIO.setup CLK, as: :output
    $_gpio_setup = true
  end

  _sof

  $pixels.each do |pixel|
    r, g, b, brightness = pixel
    _write_byte(0b11100000 | brightness)
    _write_byte(b)
    _write_byte(g)
    _write_byte(r)
  end

  _eof
end

# Set the RGB value and optionally brightness of all pixels
# If you don't supply a brightness value, the last value set
# for each pixel be kept.
# Params:
# +r+:: Amount of red: 0 to 255
# +g+:: Amount of green: 0 to 255
# +b+:: Amount of blue: 0 to 255
# +brightness+:: Brightness: 0.0 to 1.0 (default around 0.2)
def set_all(r, g, b, brightness = nil)
  (0..(NUM_PIXELS - 1)).each do |x|
    set_pixel(x, r, g, b, brightness)
  end
end

# Set the RGB value, and optionally brightness, of a single pixel
# If you don't supply a brightness value, the last value will be kept.
# Params:
# +x+:: The horizontal position of the pixel: 0 to 7
# +r+:: Amount of red: 0 to 255
# +g+:: Amount of green: 0 to 255
# +b+:: Amount of blue: 0 to 255
# +brightness+:: Brightness: 0.0 to 1.0 (default around 0.2)
def set_pixel(x, r, g, b, brightness = nil)
  brightness = if brightness.nil?
                 $pixels[x][3]
               else
                 (31.0 * brightness).to_i & 0b11111
               end

  $pixels[x] = [r.to_i & 0xff, g.to_i & 0xff, b.to_i & 0xff, brightness]
end

# Set whether Blinkt! should be cleared upon exit
# By default Blinkt! will turn off the pixels on exit, but calling::
#   blinkt.set_clear_on_exit(False)
# Will ensure that it does not.
# Params:
# +value+:: true or false (default true)
def set_clear_on_exit(value = true)
  $_clear_on_exit = value
end

at_exit do
  if $_clear_on_exit
    clear
    show
  end
  RPi::GPIO.clean_up
end
