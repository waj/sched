class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.datetime :at
      t.integer :interval
      t.string :url, :length => 1000
      t.integer :retries

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
