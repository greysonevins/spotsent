class AddTitleToBuzzs < ActiveRecord::Migration
  def change
    add_column :buzzs, :title, :string
  end
end
