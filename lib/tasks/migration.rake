namespace :migration do
  desc "Import CESPI WEB contact numbers from json file"
  task :contacts, [:path] => :environment do |t, args|
    if args.nil? 
      puts "Enter the file path in order to execute this task. Please, execute it again with the corresponding argument"
    end
    if File.exist? args.path
      puts "Importing file to data base ...."
      file = File.read(args.path)
      data_hash = JSON.parse(file, symbolize_names: true)
      data_hash.each do |contact|
        unless empty_contact? contact
          institution ||= Contact.find_or_initialize_by(name: contact[:institution], type: 'Institution')
          dependency  ||= Contact.find_or_initialize_by(name: contact[:dependency], type: 'Dependency')
          dependency.update_attribute(:parent, institution) unless dependency.parent.present?
          office = Contact.new(name: contact[:office], parent: dependency, type: 'Office')
          institution.save
          dependency.save
          office.save
        end
      end
      puts "End of migration."
    else
      puts "File not found. Execute the task again with a valid file path."
    end
  end

end

def empty_contact?(contact)
  contact.values.reject { |v| v.blank? }.blank?
end
