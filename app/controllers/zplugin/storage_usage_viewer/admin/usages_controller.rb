class Zplugin::StorageUsageViewer::Admin::UsagesController < Zplugin::StorageUsageViewer::Admin::BaseController

  def pre_dispatch
    @policy = authorize(Zplugin::StorageUsageViewer::UsagePolicy)
  end

  def index
    usages = Zplugin::StorageUsageViewer::Usage.all
    @criteria = criteria
    items = Zplugin::StorageUsageViewer::UsagesFinder.call(usages, @criteria)
                                   .order(size: :desc, id: :desc)

    if params[:csv]
      csv = Zplugin::StorageUsageViewer::Export::UsagesInteractor.call(items: items).result
      return send_data platform_encode(csv), type: Rack::Mime.mime_type('.csv'), filename: "storage_usages_#{Time.now.strftime('%Y%m%d_%H%M%S')}.csv"
    end

    @items = items.paginate(page: params[:page], per_page: params[:limit])
    _index @items
  end

  private

  def criteria
    Zplugin::StorageUsageViewer::UsageCriteria.new(params[:criteria]&.permit!)
  end
end
