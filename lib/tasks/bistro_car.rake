desc "Generate the cached bundle/application.js file from app/scripts/*.coffee files"
task :bistro_car => :environment do
  path = "public/javascripts/application.js"
  puts "Building *.coffee -> #{path}"
  File.open(path, "w") { |file| file << BistroCar::Bundle.new('default').to_javascript }
end

file "public/javascripts/application.js" => Dir[File.join(Rails.root, 'app/scripts/*.coffee')] do |t|
  Rake::Task["bistro_car"].invoke
end