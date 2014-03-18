class CreateRequests < ActiveRecord::Migration
    def up
      create_table :requests do |t|
        t.string :url
        t.integer :response
      end
    end

    def down
      drop_table :requests
    end
end
