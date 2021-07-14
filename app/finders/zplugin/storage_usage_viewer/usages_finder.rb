class Zplugin::StorageUsageViewer::UsagesFinder < ApplicationFinder
  parameters :site_name

  def site_name(value)
    sites = Cms::Site.arel_table
    @relation.joins(:site).where(sites[:name].matches("%#{value}%"))
  end
end
