class AddDescriptionFieldToQueueds < ActiveRecord::Migration
  def change
    add_column :queueds, :description, :text
  end
end
