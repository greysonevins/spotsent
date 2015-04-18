class CreateBuzzs < ActiveRecord::Migration
  def change
    create_table :buzzs do |t|
      t.string :buzz_id
      t.string :sentiment_score

      t.timestamps null: false
    end
  end
end
