class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :played_at

      t.timestamps null: false
    end
  end
end
