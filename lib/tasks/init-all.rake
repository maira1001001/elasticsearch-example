namespace :elasticsearch_example do
  desc "migrate contacts.json, index data with elasticsearch."
  task :init_all => :environment do |t, args|

    index_name = Settings.elasticsearch.default_settings.index_name
    puts "Deleting #{index_name}..."
    begin
      Contact.__elasticsearch__.delete_index!
      puts "#{index_name} deleted."
    rescue Elasticsearch::Transport::Transport::Errors::NotFound
      puts "There is no index #{index_name} to remove."
    end

    puts "Dropping Data Base..."
    Rake::Task["db:drop"].invoke

    puts "Creating Data Base..."
    Rake::Task["db:create"].invoke

    puts "Migrating Data Base..."
    Rake::Task["db:migrate"].invoke

    puts "Populating Data Base..."
    Rake::Task["db:seed"].invoke

    puts "Executing rake task:  migration:contacts\[contacts.json\] \n"
    Rake::Task["migration:contacts"].invoke('contacts.json')

    puts "End of task init_all"

  end
end
