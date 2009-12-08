class CharacterJobsController < ApplicationController

  def update
    character_job = CharacterJob.find(params[:id])
    previous_level = character_job.job_level
    if character_job.update_attributes(params[:character_job])
      html_to_change = {}
      character_job.opened_up_jobs(previous_level).each do |cj|
        html_to_change["#character_job_#{cj.id}"] ||= {}
        html_to_change["#character_job_#{cj.id}"]["input"] = input_for_job_level(cj)
        html_to_change["#character_job_#{cj.id}"]["class"] = "mastery#{cj.percent_mastery(true)}"
      end
      render :json => html_to_change
    else
      render :json => "false"
    end
  end
  
  private
  
  def input_for_job_level(character_job)
    "<input id=\"character_job_#{character_job.id}_job_level\" class=\"job_level\" type=\"text\" value=\"#{character_job.job_level}\" name=\"character_job[#{character_job.id}][job_level]\"/>"
  end
end