require_relative 'rails/unused/version'

module RailsUnused
  class Error < StandardError; end

  def self.run
    unused_controllers = find_unused_controllers
    unused_models      = find_unused_models
    unused_services    = find_unused_services

    puts 'Possíveis controllers não utilizados:'
    if unused_controllers.empty?
      puts '  (nenhum controller parece estar sem uso)'
    else
      unused_controllers.each { |ctr| puts "  - #{ctr}" }
    end

    puts "\nPossíveis models não utilizados:"
    if unused_models.empty?
      puts '  (nenhum model parece estar sem uso)'
    else
      unused_models.each { |mdl| puts "  - #{mdl}" }
    end

    puts "\nPossíveis services não utilizados:"
    if unused_services.empty?
      puts '  (nenhum service parece estar sem uso)'
    else
      unused_services.each { |svc| puts "  - #{svc}" }
    end
  end

  def self.find_unused_controllers
    unused = []
    files = Dir.glob('app/controllers/**/*_controller.rb')
    print "Analisando controllers:\n"
    files.each do |file|
      content = File.read(file)
      next unless content =~ /class\s+([A-Za-z0-9_:+]+)/

      controller_class = ::Regexp.last_match(1)

      routes_text = File.exist?('config/routes.rb') ? File.read('config/routes.rb') : ''
      base_name = controller_class.gsub(/Controller$/, '')
      unused << controller_class unless routes_text.include?("#{base_name.downcase}#")

      print '.'
      $stdout.flush
    end
    puts " (#{files.size} arquivos analisados)"
    unused
  end

  def self.find_unused_models
    unused = []
    all_files = Dir.glob('{app,config,lib}/**/*.rb')
    files = Dir.glob('app/models/**/*.rb')
    print "Analisando models:\n"
    files.each do |file|
      content = File.read(file)
      next unless content =~ /class\s+([A-Za-z0-9_:+]+)/

      model_class = ::Regexp.last_match(1).split('<').first.strip

      reference_found = false
      all_files.each do |f|
        next if f == file

        text = File.read(f)
        if text.include?(model_class)
          reference_found = true
          break
        end
      end
      unused << model_class unless reference_found

      print '.'
      $stdout.flush
    end
    puts " (#{files.size} arquivos analisados)"
    unused
  end

  def self.find_unused_services
    unused = []
    all_files = Dir.glob('{app,config,lib}/**/*.rb')
    files = Dir.glob('app/services/**/*.rb')
    print "Analisando services:\n"
    files.each do |file|
      content = File.read(file)
      next unless content =~ /class\s+([A-Za-z0-9_:+]+)/

      service_class = ::Regexp.last_match(1).split('<').first.strip

      reference_found = false
      all_files.each do |f|
        next if f == file

        text = File.read(f)
        if text.include?(service_class)
          reference_found = true
          break
        end
      end
      unused << service_class unless reference_found

      print '.'
      $stdout.flush
    end
    puts " (#{files.size} arquivos analisados)"
    unused
  end
end
