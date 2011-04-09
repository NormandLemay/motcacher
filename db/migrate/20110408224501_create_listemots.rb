class CreateListemots < ActiveRecord::Migration
  def self.up
    create_table :listemots do |t|
      t.integer :id_grille
      t.integer :id_lexique

      t.timestamps
    end
  end

  def self.down
    drop_table :listemots
  end
end
