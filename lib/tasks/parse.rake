namespace :parse do
  desc "Parse  cespi web to JSON file"
  task :cespi_web, [:path] => :environment do |t, args|

    fail "Enter the path name" if args.path.nil?
    parser = Parser::CespiWeb.new(args.path)
    parser.parse_html
    puts "End of parsing."

  end
end

