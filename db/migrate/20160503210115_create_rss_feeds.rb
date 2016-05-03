class CreateRssFeeds < ActiveRecord::Migration
  def change
    create_table :rss_feeds do |t|
      t.string :title, null: false
      t.string :link, null: false
      t.string :description, null: false
      t.timestamps null: false
    end
  end
end
