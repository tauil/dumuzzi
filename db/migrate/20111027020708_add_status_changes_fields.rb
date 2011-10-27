class AddStatusChangesFields < ActiveRecord::Migration
  def change
    add_column :status_changes, :subject, :string
  end
end
