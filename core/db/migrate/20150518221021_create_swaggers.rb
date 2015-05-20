class CreateSwaggers < ActiveRecord::Migration
  def change
    create_table :swaggers do |t|

      t.timestamps null: false
    end
  end
end
