namespace Zomeki::NAME do
  namespace :storage_usage_viewer do
    namespace :usages do
      desc 'Check storage usages'
      task check: [:environment] do
        Zplugin::StorageUsageViewer::CheckJob.perform_later
      end
    end
  end
end
