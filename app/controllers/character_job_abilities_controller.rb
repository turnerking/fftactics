class CharacterJobAbilitiesController < ApplicationController
  before_filter :find_character_job_ability

  def update
    @character_job_ability.update_attribute(:completed, !@character_job_ability.completed?)
    
    render :json => {:id => "#{@character_job_ability.id}", 
                     :character_job_element => "#character_job_#{@character_job_ability.character_job.id}",
                     :mastery_class => @character_job_ability.character_job.get_mastery_css_class}
  end

  private
  def find_character_job_ability
    @character_job_ability = CharacterJobAbility.find(params[:id]) if params[:id]
  end
end