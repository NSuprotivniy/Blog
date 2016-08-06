class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|

    	t.integer :post_id

      t.timestamps null: false
    end

    change_table :pictures do |t|
      t.attachment :image
    end

  end
end
