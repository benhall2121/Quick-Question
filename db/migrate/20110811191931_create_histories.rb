class CreateHistories < ActiveRecord::Migration
  def self.up
    create_table :histories do |t|
      t.integer :project_id
      t.integer :task_id

      t.timestamps
    end
  end

  def self.down
    drop_table :histories
  end
end
