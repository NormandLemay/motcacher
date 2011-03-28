class CreateGrilles < ActiveRecord::Migration
  def self.up
    create_table :grilles do |t|
      t.text :lettres
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :grilles
  end
end
