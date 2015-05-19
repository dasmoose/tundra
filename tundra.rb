#!/usr/bin/env ruby

# setup gem include path
require 'rubygems'
require 'bundler/setup'

# Adds project directory to beginning of ruby load path.
# This means that you don't have to append a './' before every local file
# TODO find a better solution
$LOAD_PATH.unshift File.expand_path(Dir.pwd)

require 'lib/cli'
require 'lib/config'

# load config
Tundra::Config.load()

# run cli
Tundra::Cli.run()
