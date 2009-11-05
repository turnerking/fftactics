# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def get_job_class(character_job)
    if character_job.mastered?
      "master#{character_job.job_level}"
    else
      "job_level#{character_job.job_level}"
    end
  end
end
