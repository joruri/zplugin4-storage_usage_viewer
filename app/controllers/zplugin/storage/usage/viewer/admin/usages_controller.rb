class Zplugin::Storage::Usage::Viewer::Admin::UsagesController < Zplugin::Storage::Usage::Viewer::Admin::BaseController

  def pre_dispatch
    @policy = authorize(policy: Zplugin::Storage::Usage::Viewer::UsagePolicy)
  end

  def index
    @criteria = criteria
    @items = Zplugin::Storage::Usage::Viewer::Usage.finder(@criteria).order(size: :desc)
    @items = @items.paginate(page: params[:page], per_page: params[:limit])

    if params[:csv]
      csv = Zplugin::Storage::Usage::Viewer::Export::UsagesInteractor.call(items: @items).result
      return send_data platform_encode(csv), type: Rack::Mime.mime_type('.csv'), filename: "files_#{Time.now.strftime('%Y%m%d_%H%M%S')}.csv"
    end
  end

  private

  def criteria
    Zplugin::Storage::Usage::Viewer::UsageCriteria.new(params[:criteria]&.permit!)
  end
end
