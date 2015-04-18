class AddImageAndUrlToBuzz < ActiveRecord::Migration
  def change
  	add_column :buzzs, :image_url, :string
  	add_column :buzzs, :username, :string
  	add_column :buzzs, :uri, :string

  	remove_index :editabilities, [:buzz_id, :sentiment_score, :created_at, :updated_at, :image_url, :username, :uri]
  	add_index :editabilities, [:buzz_id, :sentiment_score, :created_at, :updated_at, :image_url, :username, :uri], unique: true
  end
end
