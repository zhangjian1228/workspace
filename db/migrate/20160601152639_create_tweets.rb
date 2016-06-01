class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :t_id
      t.text :body
      t.date :t_created_at

      t.timestamps null: false
    end
  end
end
