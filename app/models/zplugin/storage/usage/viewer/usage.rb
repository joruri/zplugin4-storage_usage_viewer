class Zplugin::Storage::Usage::Viewer::Usage < ApplicationRecord
  belongs_to :site, class_name: 'Cms::Site'

  def eng_unit
    ApplicationController.helpers.number_to_human_size(size)
  end
end
