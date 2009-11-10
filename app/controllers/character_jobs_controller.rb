class CharacterJobsController < ApplicationController

  def update
    character_job = CharacterJob.find(params[:id])
    if character_job.update_attributes(params[:character_job])
      render :json => "true"
    else
      render :json => "false"
    end
  end

end