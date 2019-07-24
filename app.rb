require 'bundler'
Bundler.require

:.unshift File.expand_path("./../lib", __FILE__)
require 'app/EmailScrapper' #plus besoin de préciser le path exact
require 'views/'