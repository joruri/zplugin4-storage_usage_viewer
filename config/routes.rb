Zplugin::Storage::Usage::Viewer::Engine.routes.draw do
  root 'admin/usages#index'

  scope module: 'admin' do
    resources :usages, only: [:index]
  end
end
