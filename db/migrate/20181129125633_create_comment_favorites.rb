class CreateCommentFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_favorites do |t|
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
