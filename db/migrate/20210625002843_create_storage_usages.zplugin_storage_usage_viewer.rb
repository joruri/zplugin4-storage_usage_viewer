class CreateStorageUsages < ActiveRecord::Migration[5.0]
  def change
    create_table "zplugin_storage_usage_viewer_usages" do |t|
      t.integer "site_id"
      t.integer "size"
      t.timestamps
    end

  end
end
