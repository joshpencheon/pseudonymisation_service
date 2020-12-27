Rails.application.routes.draw do
  scope '/api/v1' do
    # List available keys:
    get '/keys', to: 'pseudonymisation_keys#index', as: :pseudonymisation_keys

    # List available variants:
    get '/variants', to: 'variants#index', as: :variants

    # Perform Pseudonymisation:
    post '/pseudonymise', to: 'pseudonymisation#pseudonymise'
  end

  get '/health', to: 'health_check#health'

  root 'application#info'
end
