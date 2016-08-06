Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :banners, only: [:index]
  resource :home, only: [:show]

  ############ SMS Routes ###################
  resources :sms_tokens, only: [:show]  do
    collection do
      post 'register'
    end
  end
  ###########################################

  ########### UserInfo Route ################
  resource :user_info, only: [:show, :update]
  ###########################################

  ########### Sport Route ####
  resources :sports, only: [:create, :show] do
    collection do
      get 'daily'
      get 'weekly'
      get 'monthly'
      get 'yearly'
    end
  end

  # 获取具体的排名，支持分页
  resources :ranks, only: [:show] do
    collection do
      get 'daily'
      get 'weekly'
      get 'monthly'
      get 'yearly'
    end
  end
  ###########################################

  ########### Appointment Route ###########################
  resources :appointments, only: [:show, :create, :index]
  ##########################################################


  ########### Product Route ###########################
  resources :products, only: [:show, :index]
  resources :cart_items do
    collection do
      post :pay
    end
  end
  resources :contacts
  ##########################################################

  ##########################################################
  wash_out :healthy_services
  ##########################################################
end
