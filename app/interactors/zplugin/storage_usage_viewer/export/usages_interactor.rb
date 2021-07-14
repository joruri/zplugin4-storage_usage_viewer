class Zplugin::StorageUsageViewer::Export::UsagesInteractor < ApplicationInteractor
  before_call do
    @items = @context.items
  end

  def call
    require 'csv'
    @context.result = CSV.generate do |csv|
      csv << [
        "ID",
        "サイト名",
        "使用量",
        "更新日",
      ]
      @items.each do |item|
        csv << [
          item.site&.id,
          item.site&.name,
          item.eng_unit,
          item.updated_at.try(:strftime, '%Y/%m/%d %H:%M:%S')
        ]
      end
    end
  end
end
