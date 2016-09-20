![Blinkt!](blinkt-logo.png)

A Ruby port of the [Pimoroni Blinkt Python library](https://github.com/pimoroni/blinkt).

[![Gem Version](https://badge.fury.io/rb/blinkt.svg)](https://badge.fury.io/rb/blinkt)

Blinkt provides eight super-bright RGB LED indicators, ideal for adding visual notifications to your Raspberry Pi on their own or on a pHAT stacking header.

Available from Pimoroni: https://shop.pimoroni.com/products/blinkt

## Installation

The Blinkt library can be installed from Rubygems:

    # gem install blinkt

## Usage

The two Blinkt methods you'll most commonly use are `set_pixel` and `show`. Here's a simple example:

```
require 'blinkt'

set_pixel(0,255,0,0)
show
```

`set_pixel` takes an optional fifth parameter; the brightness from 0.0 to 1.0.

`set_pixel(pixel_no, red, green, blue, brightness)`

You can also change the brightness with `set_brightness` from 0.0 to 1.0, for example:

```
require 'blinkt'

set_brightness(0.5)
show
```

It is also possible to clear any already lit pixels with `clear`, set all pixels at once with `set_all` and to have all pixels clear on exit with `set_clear_on_exit`.

```
require 'blinkt'

clear
set_clear_on_exit
set_all(255,0,0)
show
```

`set_all` takes an optional fourth parameter; the brightness from 0.0 to 1.0.

`set_all(red, green, blue, brightness)`

## Examples

The examples in the `examples` folder should just work with Blinkt!

## Version Information

The Ruby Blinkt gem version corresponds to the Python lib versions in the following table:

| Ruby Gem Version | Python Lib Version |
| ---------------- | ------------------ |
| 0.0.3            | [0.1.0](https://github.com/pimoroni/blinkt/tree/3c493b85745d8a850dce60a3933cc71a3b8aa789)              |
