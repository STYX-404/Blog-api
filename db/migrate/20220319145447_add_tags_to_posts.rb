class AddTagsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :tags, :json
  end
end
