# frozen_string_literal: true

class Song < ApplicationRecord
  has_many :charts
  has_many :song_categories
end
