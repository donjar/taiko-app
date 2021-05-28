# frozen_string_literal: true

class SongCategory < ApplicationRecord
  belongs_to :song
  belongs_to :category
end
