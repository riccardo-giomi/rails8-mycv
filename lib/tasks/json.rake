namespace :json do
  desc "List all JSON files in import/export directory"
  task :list do
    path = file_path
    puts
    puts "Exported CV files in #{path}:"
    puts

    Dir.glob("*.json", base: path) do |filename|
      puts filename
    end
  end

  desc "Creates a JSON file in storage/json/:filename with data from CV.find(:cv_id).
        :filename default to Cv#base_filename.json"
  task :export, [ :cv_id, :filename ] => [ :environment ] do |task, args|
    unless args.cv_id.present?
      say_and_exit("Usage:\nbin/rails json:export[:cv_id[, :filename]]")
    end

    cv = Cv.find(args.cv_id.to_i)
    filename = args.filename || "#{cv.base_filename}.json" || "cv-#{cv_id}.json"
    path = file_path(filename)

    if File.exist?(path)
      say_and_exit(%(File "#{path}" already exists, I cowardly refuse to overwrite it.))
    end

    File.write(path, cv.build_copy.to_json)
  end

  desc "Creates a new CV from the data in the JSON file storage/json/:filename."
  task :import, [ :filename ] => [ :environment ] do |task, args|
    filename = args.filename

    unless filename.present?
      puts
      puts "Usage:"
      puts "bin/rails json:import[:filename]"
      puts
      exit
    end

    path = file_path(filename)
    unless File.exist?(path)
      say_and_exit(%(File not found: #{path}"))
    end

    json = File.read(path)
    Cv.from_json(json).save
  end
end

def file_path(filename = nil)
  Rails.root.join("storage", "json", filename.to_s)
end

def say_and_exit(text)
  puts ; puts text ; puts
  exit
end
