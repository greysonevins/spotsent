class CreateBuzzs < ActiveRecord::Migration
  def change
    create_table :buzzs do |t|
      t.string :buzz_id
      t.float :sentiment_score
 
      t.timestamps null: false
    end
    
    add_index :buzzs, :buzz_id, :unique => true
  end
end