SygiopsSupport::Engine.routes.draw do

  resources :channel_emails do
    collection do
      post :probe
      post :inbound
      post :outbound
      post :verify
    end
  end

  mount ActionCable.server => '/cable'

  resources :tickets do
    collection do
      post :send_reply
      get :get_options
    end
  end

  resources :ticket_articles do
    collection do
      # get :attachment
    end
  end

  resources :ticket_types
  resources :ticket_priority
  resources :calendars

  resources :users do
    collection do
      get :email_address
    end
  end

  resources :groups do
    collection do
      get :fetch_datas
      get :send_notification
      get :get_options
    end
  end

  resources :slas do
    collection do
      get :fetch_datas
    end
  end

  resources :organizations do
    collection do
      get :fetch_timezones
    end
  end

match '/ticket_attachment/:ticket_id/:article_id/:id',  to: 'ticket_articles#attachment',      via: :get
match '/ticket_article_plain/:id',                      to: 'ticket_articles#article_plain',   via: :get

end
