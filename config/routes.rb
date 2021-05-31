# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'scores#list_cards'
  get '/cards', to: 'scores#list_cards'
end
