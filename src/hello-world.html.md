---
title: Hello World
date: 2017/08/17
---
# This is an amazing title of something interesting

![Pretty Gophers](hello-world/fiveyears.jpg)

## In the beginning

<mark>Lorem ipsum dolor sit amet, consectetur adipisicing elit</mark>. Aliquam atque beatae culpa error, excepturi illum ipsum magnam magni modi nesciunt nihil nulla obcaecati omnis praesentium quaerat quam quis repudiandae sed.
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam atque beatae culpa error, excepturi illum ipsum magnam magni modi nesciunt nihil nulla obcaecati omnis praesentium quaerat quam quis repudiandae sed.

Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam atque beatae culpa error, excepturi illum ipsum magnam magni modi nesciunt nihil nulla obcaecati omnis praesentium quaerat quam quis repudiandae sed.


## Some amaze code

```ruby
module Shelter
  class CommandParser < Struct.new(:cmd)
    DEFAULT_COMMAND = -> { Shelter::Commands::Command }

    def parse(something)
      puts "Hello #{something}"
      commands.detect(DEFAULT_COMMAND) do |command|
        command.match?(cmd)
      end.new(cmd)
    end

    private
    def commands
      @commands ||= _commands
    end

    def _commands
      Shelter::Commands.constants.inject([]) do |memo, constant|
        c = Shelter::Commands.const_get(constant)
        memo << c if c.respond_to?(:match?)
        memo
      end
    end
  end
end
```


## That's all folks

Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam atque beatae culpa error, excepturi illum ipsum magnam magni modi nesciunt nihil nulla obcaecati omnis praesentium quaerat quam quis repudiandae sed.
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam atque beatae culpa error, excepturi illum ipsum magnam magni modi nesciunt nihil nulla obcaecati omnis praesentium quaerat quam quis repudiandae sed.
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam atque beatae culpa error, excepturi illum ipsum magnam magni modi nesciunt nihil nulla obcaecati omnis praesentium quaerat quam quis repudiandae sed.
