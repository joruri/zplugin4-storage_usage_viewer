class Zplugin::Storage::Usage::Viewer::Export::UsagesInteractor < ApplicationInteractor
  before do
    @items = @context.items
  end

  def call
    require 'csv'
    @context.result = CSV.generate do |csv|
      csv << [
        "サイト名",
        "使用量",
        "更新日",
      ]
      @items.find_each do |item|
        csv << [
          item.site&.name,
          item.eng_unit,
          item.updated_at.try(:strftime, '%Y/%m/%d %H:%M:%S')
        ]
      end
    end
  end
end
