Rails.application.routes.draw do
  root 'top#index'

  resources :blogs, only: [:index, :new, :create, :edit, :update, :destroy] do
   collection do
      post :confirm
   end
  end

  resources :blogs do
   resources :comments
   post :confirm, on: :collection
  end

  resources :contacts, only: [:new, :create] do
   collection do
     post :confirm
   end
 end

 resources :poems, only: [:index, :show]



 resources :relationships, only: [:create, :destroy]

 devise_for :users, controllers: {
   registrations: "users/registrations",
   omniauth_callbacks: "users/omniauth_callbacks"
  }

 resources :users, only: [:index, :show]

 resources :conversations do
  resources :messages
end


 if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
 end

end
