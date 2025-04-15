require_relative 'lib/rails/unused/version'

Gem::Specification.new do |spec|
  spec.name        = 'rails_unused'
  spec.version     = Rails::Unused::VERSION
  spec.authors     = ['Ricardo Grassi']
  spec.email       = ['grassiricardorg@gmail.com']

  spec.summary     = 'Detector de código morto para aplicações Rails'
  spec.description = 'rails_unused é uma ferramenta CLI que analisa um projeto Ruby on Rails e lista controllers, models e services potencialmente não utilizados no código.'
  spec.homepage    = 'https://github.com/grassiricardo/rails_unused'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 2.6'

  spec.files         = Dir['lib/**/*', 'exe/*', 'README.md', 'ROADMAP.md']
  spec.bindir        = 'exe'
  spec.executables   = ['rails_unused']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
