# mrbrspec

A very light (incomplete) reproduction of the RSpec experience with mruby.

Relies on Ruby (CRuby), `mrbc` and `mruby`.

mrbrspec will use the `spec` directory in your project. For the code it tests, it makes the assumption this is already compiled along with mruby.

## Installation

mrbrspec can be installed with (the regular CRuby) Bundler.

``` bash
gem "mrbrspec", git: "https://github.com/Dan2552/mrbrspec"
```

## Usage

Run the following:

``` bash
bundle exec mrbrspec
```

## Example full usage

An example intended usage is you have a hybrid Ruby gem (CRuby) and mrbgem (mruby), but want the same set of specs for both.

In this case the `Gemfile` may look like:
``` ruby
source "https://rubygems.org"

gemspec

gem "mundler", git: "https://github.com/Dan2552/mundler"
gem "mrbrspec", git: "https://github.com/Dan2552/mrbrspec"

```

The `Mundlefile` may look like:

``` ruby
mruby tag: "3.0.0"

gembox "default"
gem "my_gem", path: "."
```

By running the following, will compile the gem, and then run specs:

``` bash
bundle exec mundle update # (Re)compile mruby and the mrbgem
bundle exec mrbrspec # Run specs
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
