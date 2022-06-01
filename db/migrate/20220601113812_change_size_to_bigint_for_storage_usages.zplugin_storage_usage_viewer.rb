class ChangeSizeToBigintForStorageUsages < ActiveRecord::Migration[5.0]
  def change
    change_column :zplugin_storage_usage_viewer_usages, :size, :bigint
  end
end
