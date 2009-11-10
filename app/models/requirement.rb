class Requirement < ActiveRecord::Base
  belongs_to :derived_job, :class_name => "Job"
  belongs_to :required_job, :class_name => "Job"
end
