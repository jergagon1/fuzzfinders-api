class RemoveArticleTags < ActiveRecord::Migration
  def change
    drop_join_table :articles, :tags, table_name: :article_tags
  end
end
