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

file = File.read('lib/requirements.yml')
requirements_hash = YAML::load(file)

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

Job::BASE_JOBS.each do |job|
  derived_job = Job.find_by_name(job)
  unless requirements_hash[job.downcase.to_sym].nil?
    requirements_hash[job.downcase.to_sym].each do |requirement|
      required_job = Job.find_by_name(requirement[:job])
      derived_job.required << Requirement.create!(:required_job => required_job, :required_level => requirement[:job_level])
      puts "#{derived_job.name} requires a level #{requirement[:job_level]} #{required_job.name}"
    end
  end
end
