# frozen_string_literal: true

require 'rails_unused'

RSpec.describe RailsUnused do
  it 'has a version number' do
    expect(Rails::Unused::VERSION).not_to be nil
  end

  describe '.run' do
    before do
      # Cria pastas fake
      FileUtils.mkdir_p('app/controllers')
      FileUtils.mkdir_p('app/models')
      FileUtils.mkdir_p('app/services')
      FileUtils.mkdir_p('config')

      # Cria um controller não utilizado
      File.write('app/controllers/old_controller.rb', <<~RUBY)
        class OldController < ApplicationController
        end
      RUBY

      # Cria um model não utilizado
      File.write('app/models/old_model.rb', <<~RUBY)
        class OldModel < ApplicationRecord
        end
      RUBY

      # Cria um service não utilizado
      File.write('app/services/old_service.rb', <<~RUBY)
        class OldService
        end
      RUBY

      # Cria um arquivo de rotas vazio
      File.write('config/routes.rb', '')
    end

    after do
      FileUtils.rm_rf('app')
      FileUtils.rm_rf('config')
    end

    it 'detects unused code' do
      output = capture_stdout { RailsUnused.run }

      expect(output).to include('OldController')
      expect(output).to include('OldModel')
      expect(output).to include('OldService')
    end
  end

  def capture_stdout
    original_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = original_stdout
  end
end
