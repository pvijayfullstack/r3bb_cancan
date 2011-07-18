class Activity < ActiveRecord::Base
  belongs_to :workout
  belongs_to :exercise
  validates_presence_of :resistance, :repetitions
  
  attr_accessor :new_exercise_name
  before_save :create_exercise_if_submitted
  
  def create_exercise_if_submitted 
    create_exercise(:user_id => workout.user_id, :name => new_exercise_name) unless new_exercise_name.blank?   
  end
end
