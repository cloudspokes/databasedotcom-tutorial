class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :First_Name
      t.string :Last_Name
      t.string :Gender
      t.integer :Age
      t.date :Date_of_Birth
      t.text :Email
      t.date :ExpectedEndDate
      t.date :ProgramStartDate

      t.timestamps
    end
  end
end
