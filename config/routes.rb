# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'scores#list_cards'
  get '/random', to: 'scores#random'
end
