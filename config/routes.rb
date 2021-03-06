Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :sessions => "custom_sessions", registrations: 'registrations' }
  resources :banners, only: [:index]
  resource :home, only: [:show]
  get 'home_info', to: 'homes#home_info'
  
  ######################################
  # 为了新系统，增加老系统根据user手机号换取token的接口
  ######################################
  namespace :user do
    resource :token, only: [:create]
  end
  ############ SMS Routes ###################
  resources :sms_tokens, only: [:show]  do
    collection do
      post 'register'
    end
  end
  ###########################################

  ########### UserInfo Route ################
  resource :user_info, only: [:show, :update] do
    member do
      post 'reset'
    end
  end
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

  ########### Activity Route ###########################
  namespace :activity do
    resources :sqhds, only: [:index, :show] do
      member do
        post :appoint
      end
    end
  end
  ##########################################################
  
  ########### Product Route ###########################
  resources :products, only: [:show, :index] do
    collection do 
      get :sort 
    end
  end
  resources :product_sorts 
  resources :cart_items do
    collection do
      post :pay
    end
  end
  resources :contacts
  resources :orders, only: [:index, :show, :create, :destroy] do 
    member do 
      post 'recover_stocks' 
      post 'create_payment' 
    end
    collection do 
      post 'create_by_promotion'
    end
  end
  ############################################################

  ################### 限量销售 ####################
  resources :promotions, only: [:index, :show] 
  ##########################################################

  ################  健康小屋体检机器相关的接口路由   ###################
  # 给体检机器提供的webservice接口
  wash_out :healthy_services

  # 提供APP查询的接口
  resources :reports, only: [:index] do
    collection do
      get ':item', action: :show
    end
  end
  resources :news_sorts, only: [:index, :show] do 
    resources :news, only: [:index, :show]
  end

  ##########################################################
  ##
  ################  客服信息相关的接口路由   ###################
  resources :customer_services
  ##########################################################

  ################  分社区相关的接口路由   ###################
  resources :subdistricts
  ##########################################################
  ##
  ############# Pingpp Routes ###########################
  post 'get_pingpp_pay_order', to: 'pingpp#get_pay_order'
  post 'get_pingpp_webhooks', to: 'pingpp#get_pingpp_webhooks'
  #####################################################
end
