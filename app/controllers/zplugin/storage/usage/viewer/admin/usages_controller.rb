class Zplugin::Storage::Usage::Viewer::Admin::UsagesController < Zplugin::Storage::Usage::Viewer::Admin::BaseController

  def pre_dispatch
    @policy = authorize(Zplugin::Storage::Usage::Viewer::UsagePolicy)
  end

  def index
    usages = Zplugin::Storage::Usage::Viewer::Usage.all
    @criteria = criteria
    items = Zplugin::Storage::Usage::Viewer::UsagesFinder.call(usages, @criteria)
                                   .order(size: :desc, id: :desc)

    if params[:csv]
      csv = Zplugin::Storage::Usage::Viewer::Export::UsagesInteractor.call(items: items).result
      return send_data platform_encode(csv), type: Rack::Mime.mime_type('.csv'), filename: "storage_usages_#{Time.now.strftime('%Y%m%d_%H%M%S')}.csv"
    end

    @items = items.paginate(page: params[:page], per_page: params[:limit])
    _index @items
  end

  private

  def criteria
    Zplugin::Storage::Usage::Viewer::UsageCriteria.new(params[:criteria]&.permit!)
  end
end
