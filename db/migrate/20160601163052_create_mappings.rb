class CreateMappings < ActiveRecord::Migration
  def change
    create_table :mappings do |t|
      t.string :url
      t.belongs_to :tweet # tweet_id:integer

      t.timestamps null: false
    end
  end
end
