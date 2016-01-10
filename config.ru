#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require File.expand_path("../config/boot.rb", __FILE__)

class Foo
  def call(env)
    [200, {'Content-Type' => 'text/plain'}, ['Hello']]
  end
end

run Foo.new  

run Padrino.application
