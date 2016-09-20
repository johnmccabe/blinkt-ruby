Gem::Specification.new do |s|
  s.name        = 'blinkt'
  s.version     = '0.0.3'
  s.date        = '2016-09-20'
  s.summary     = 'Pimoroni Blinkt'
  s.description = 'Ruby Library for Blinkt; 8 APA102 LEDs for your Raspberry Pi https://shop.pimoroni.com/products/blinkt'
  s.authors     = ['John McCabe']
  s.email       = 'john@johnmccabe.net'
  s.files       = ['lib/blinkt.rb']
  s.homepage    = 'https://github.com/johnmccabe/blinkt-ruby'
  s.add_runtime_dependency 'rpi_gpio', ['~> 0.3', '>= 0.3.0']
end
