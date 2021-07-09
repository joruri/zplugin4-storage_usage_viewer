class Zplugin::Storage::Usage::Viewer::CheckJob < ApplicationJob
  def perform
    require "open3"

    Cms::Site.all.each do |site|
      command = "du -s #{site.root_path}"
      stdout, stderr, status = Open3.capture3(command)

      item = Zplugin::Storage::Usage::Viewer::Usage.where(site_id: site.id).first_or_initialize
      item.size = stdout.match(/^[0-9]+/)[0]
      item.updated_at = DateTime.now
      item.save
    end

  end
end
