Rails.application.routes.draw do
  mount Sidekiq::Web, at: :sidekiq

  namespace :accountancy do
    resource :session, only: :create
  end

  namespace :admin do
    resource :session, only: :create

    resource :password, only: :update
    resource :password_reset, only: [:create, :update]

    resources :licenses, only: :index
    resources :withdrawals, only: :index

    resources :lotteries do
      resource :prize_pool, controller: :lottery_prize_pools, only: :update
      resources :drawings, controller: :lottery_drawings, only: :index
    end

    resources :drawings, only: :show do
      resources :entries, controller: :drawing_entries, only: [:index, :update]
      resources :winnings, controller: :drawing_winnings, only: :index

      resource :statistics, controller: :drawing_statistics, only: :show
    end

    resources :failed_session_attempts, only: :index
  end

  namespace :consultancy do
    resource :session, only: :create

    resources :players, only: [:index, :show] do
      resources :transactions, controller: :player_transactions, only: :index
    end
  end

  namespace :regulation do
    resource :session, only: :create

    resources :licenses, except: :show

    resources :lotteries, only: [:index, :show] do
      resources :drawings, controller: :lottery_drawings, only: :index
      resource :cancellation, controller: :lottery_cancellations, only: :create
    end

    resources :drawings, only: :show do
      resource :statistics, controller: :drawing_statistics, only: :show
      resource :cancellation, controller: :drawing_cancellations, only: :create
    end
  end

  resource :session, only: :create
  resource :profile, only: [:show, :update]
  resource :password, only: :update
  resource :suspension, only: :create
  resource :loss_limits, only: :update

  resource :activation, only: :create
  resource :deactivation, only: :create
  resource :password_reset, only: [:create, :update]
  resource :onboard, only: :update


  resource :players, only: :create

  resources :photos, only: [:index, :create, :destroy]

  resources :drawings, only: :index do
    resources :entries, controller: :drawing_entries, only: :create
    resources :tickets, controller: :drawing_tickets, only: :index
  end

  scope :player do
    resources :drawings, controller: :player_drawings, only: [:index, :show]
  end

  resources :entries, only: [:index, :show] do
    resources :reveal, controller: :entry_reveals, only: :create
    resources :tickets, controller: :tickets, only: [:show, :update]
  end

  resources :tickets, only: [] do
    resource :reveal, controller: :ticket_reveals, only: :create
  end

  scope :wallet do
    resource :balance, only: :show

    resources :transactions, only: :index
    resources :deposits, only: [:create, :update]
    resources :withdrawals, only: :create
  end

  resource :subscription, except: [:index, :destroy] do
    resources :entries, controller: :subscription_entries, only: :index
    resource :cancellation, controller: :subscription_cancellations, only: :create
  end

  resources :callbacks, only: :create
end
