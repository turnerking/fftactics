class JobsController < ApplicationController

  def show
    @job = Job.find(params[:id], :include => :abilities)
  end

end