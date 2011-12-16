class Participant < ActiveRecord::Base 
  has_many :participant_profiles, :class_name => "ParticipantProfile", :foreign_key => "participant_id"
  has_many :fitness_goals, :class_name => "FitnessGoal", :foreign_key => "participant_id"
end
