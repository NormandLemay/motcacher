class AjoutListeMotCacher < ActiveRecord::Migration
  def self.up
    add_column :grilles, :listes_mots, :string
    add_column :grilles, :mot_cache, :integer
  end

  def self.down
    remove_column :grilles, :listes_mots
    remove_column :grilles, :mot_cache

  end
end
