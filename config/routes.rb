Rails.application.routes.draw do
  namespace :api do
    resources :attendances, only: [:index, :create]
    # 他のAPIエンドポイントもここに追記します
  end
end
