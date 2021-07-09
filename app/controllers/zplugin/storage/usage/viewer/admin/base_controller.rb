class Zplugin::Storage::Usage::Viewer::Admin::BaseController < Cms::Admin::BaseController
  before_action :set_plugin

  private

  def set_plugin
    @plugin = Sys::Plugin.find(params[:plugin_id])
  end
end
