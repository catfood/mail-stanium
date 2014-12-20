class CreateLookups < ActiveRecord::Migration
  def change
    create_table :lookups do |t|
      t.string :sorttype
      t.string :match
      t.string :destination

      t.timestamps
    end
  end
end
