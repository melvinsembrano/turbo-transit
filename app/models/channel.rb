# frozen_string_literal: true

class Channel < ApplicationRecord
  has_many :messages, dependent: :destroy
end
