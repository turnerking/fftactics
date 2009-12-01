# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def get_job_class(character_job)
    character_job.get_mastery_css_class
  end
  
  def requirements_for(job)
    return_string = "#{job.name} requires:\n"
    job.required.each do |req|
      return_string << "#{req.required_level} levels of #{req.required_job.name}\n"
    end
    return_string
  end
end
