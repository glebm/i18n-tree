# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'i18n-tree/version'

Gem::Specification.new do |s|
  s.name          = 'i18n-tree'
  s.version       = I18n::Tree::VERSION
  s.authors       = ['Gleb Mazovetskiy']
  s.email         = ['glex.spb@gmail.com']
  s.homepage      = 'https://github.com/glebm/i18n-tree'
  s.summary       = 'i18n locale tree using immutable data structures'
  s.description   = 'TODO: description'

  s.files         = `git ls-files app lib`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.rubyforge_project = '[none]'

  s.add_dependency 'hamster', '>= 0.4'
  s.add_dependency 'term-ansicolor'
  s.add_development_dependency 'rspec', '~> 3.0.0'
end
