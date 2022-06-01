class Zplugin::StorageUsageViewer::CheckJob < ApplicationJob
  def perform
    require "open3"

    st = DateTime.now

    Cms::Site.all.each do |site|
      command = "du -sb #{site.root_path}"
      stdout, stderr, status = Open3.capture3(command)

      item = Zplugin::StorageUsageViewer::Usage.where(site_id: site.id).first_or_initialize
      item.size = stdout.match(/^[0-9]+/)[0]
      item.updated_at = DateTime.now
      item.save
    end

    at = Zplugin::StorageUsageViewer::Usage.arel_table
    Zplugin::StorageUsageViewer::Usage.where(at[:updated_at].lt(st)).destroy_all
  end
end
