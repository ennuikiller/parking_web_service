class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.string :deviceID
      t.string :deviceToken

      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
