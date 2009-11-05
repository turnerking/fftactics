# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
require 'yaml'
file = File.read('lib/abilities.yml')
ability_hash = YAML::load(file)

Job::BASE_JOBS.each do |job|
 new_job = Job.create!(:name => job)
 puts "Created #{job}"
 unless ability_hash[job.downcase.to_sym].nil?
   ability_hash[job.downcase.to_sym].each do |ability|
    new_job.abilities << Ability.create!(:name => ability[:name], :cost => ability[:cost])
    puts "Added #{ability[:name]} to #{job}"
   end
 end
end

Game.create!

