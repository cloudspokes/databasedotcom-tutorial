class CreateParticipantProfiles < ActiveRecord::Migration
  def change
    create_table :participant_profiles do |t|
      t.decimal :BFI
      t.decimal :BFM
      t.decimal :BMI
      t.decimal :BMR
      t.string :Checkpoint
      t.decimal :F1
      t.decimal :F2
      t.integer :Height
      t.integer :Hip
      t.integer :LBM
      t.string :Name
      t.integer :Neck
      t.integer :participant_id
      t.date :RecordDate
      t.integer :Waist
      t.integer :Weight

      t.timestamps
    end
  end
end
