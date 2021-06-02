Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :boards do
    collection do
      post :player_start
    
      post :game
      post :time_passes
      delete :leave
      delete :game_over
    end
  end

end
