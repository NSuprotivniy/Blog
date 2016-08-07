class DeletePicturesFromPosts < ActiveRecord::Migration
  def change
    remove_reference :posts, :pictures, index: true, foreign_key: true
  end
end
