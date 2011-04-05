# Exemple de ce que je peux faire dans un bloc migration
#
#http://www.dizzy.co.uk/ruby_on_rails/cheatsheets/rails-migrations

class AjoutDimensionGrille < ActiveRecord::Migration
  def self.up
    add_column :grilles, :x, :integer
    add_column :grilles, :y, :integer
  end

  def self.down
    remove_column :grilles, :x
    remove_column :grilles, :y

  end
end
