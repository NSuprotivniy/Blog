class AddPicturesToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :pictures, index: true, foreign_key: true
  end
end
