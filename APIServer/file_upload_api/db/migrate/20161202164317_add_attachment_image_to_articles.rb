class AddAttachmentImageToArticles < ActiveRecord::Migration
  def self.up
      change_table :articles do |t|
        t.has_attached_file :image
      end
    end

    def self.down
      drop_attached_file :articles, :image
    end
end
