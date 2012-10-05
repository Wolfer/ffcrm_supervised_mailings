Rails.application.routes.draw do

  resources :mailings do
  	resources :mailing_mails
  	collection do
  		get 'search' 
  		get 'options' 
  		get 'options_mails' 
  		post 'auto_complete'
  		post 'redraw' 
  		post 'redraw_mails'
  	end
  	member do
  		get 'confirm' 
  		get 'check' 
  		get 'start' 
  		get 'attachment' 
      post 'filter'
      get 'filter'
  	end
  end

  resources :mailing_mails do
  	collection do 
  		get 'search' 
  		get 'options' 
  		post 'auto_complete' 
  		post 'redraw'
  	end
  	member do
  		get 'confirm' 
  		get 'add_recipient' 
  		get 'refresh_with_recipient'
  	end
  end

  [ :accounts, :contacts, :leads, :opportunities ].each do |model|
    resources model, :only => [] do
      post 'add_to_mailing', :on => :collection
    end
  end


end