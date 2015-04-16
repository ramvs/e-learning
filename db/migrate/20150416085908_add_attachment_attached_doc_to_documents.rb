class AddAttachmentAttachedDocToDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
      t.attachment :attached_doc
    end
  end

  def self.down
    remove_attachment :documents, :attached_doc
  end
end
