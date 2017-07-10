Rails.application.routes.draw do

  resources :blogs, only: [:index, :new, :create, :edit, :update, :destroy] do
   collection do
      post :confirm
   end
  end  
  resources :contacts, only: [:new, :create] do
   collection do
     post :confirm
   end
 end
 
 root 'top#index'
 
end
