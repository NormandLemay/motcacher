class CreateLexiques < ActiveRecord::Migration
  def self.up
    create_table :lexiques do |t|
      t.string :mot
      t.integer :nbr_lettre

      t.timestamps
    end
  end

  def self.down
    drop_table :lexiques
  end
end
