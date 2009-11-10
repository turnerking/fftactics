# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def get_job_class(character_job)
    character_job.get_mastery_css_class
  end
end
