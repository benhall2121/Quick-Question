class AddHashTagToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :hash_tag, :string
  end

  def self.down
    remove_column :tasks, :hash_tag
  end
end
