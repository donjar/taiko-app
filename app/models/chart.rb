# frozen_string_literal: true

class Chart < ApplicationRecord
  belongs_to :song
  has_many :scores
end
