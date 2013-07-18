namespace :import do
  
  desc "Import albums"
  task :albums => :environment do
    puts "Importing albums"

    require 'csv'
    require 'open-uri'

    csv_file = open('https://dl.dropboxusercontent.com/u/618862/albums.csv')

    # Date,Album,Artist,Host
    csv = CSV.parse(csv_file, :headers => true)

    counter = 0
    
    csv.each do |row|
      album = Album.new

      puts "#{row[1]} #{row[2]}"

      album.played_on = Date.parse('1 ' + row[0])
      album.title = row[1]
      album.artist = row[2]
      album.host = row[3]

      album.save!
      
      counter += 1
    end

    puts ">>> #{counter} of #{csv.length} albums added"

  end

end