class Zplugin::StorageUsageViewer::Export::UsagesInteractor < ApplicationInteractor
  context :items, required: true
  context :result, output: true

  def call
    require 'csv'
    @result = CSV.generate do |csv|
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
