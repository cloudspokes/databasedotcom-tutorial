class CreateFitnessGoals < ActiveRecord::Migration
  def change
    create_table :fitness_goals do |t|
      t.decimal :BFI
      t.decimal :BMI
      t.string :Name
      t.integer :participant_id
      t.decimal :Weight

      t.timestamps
    end
  end
end
