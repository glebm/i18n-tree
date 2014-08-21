# coding: utf-8
if ENV['TRAVIS'] && !(defined?(RUBY_ENGINE) && RUBY_ENGINE == 'rbx')
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

$: << File.expand_path('../lib', __FILE__)

require 'i18n-tree'
