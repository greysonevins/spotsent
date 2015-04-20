class AddImageAndUrlToBuzz < ActiveRecord::Migration
  def change
  	add_column :buzzs, :image_url, :string
  	add_column :buzzs, :username, :string
  	add_column :buzzs, :uri, :string
  	add_column :buzzs, :title, :string

  end
   add_index :title, :unique => true
end


