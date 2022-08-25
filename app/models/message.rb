# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :channel
  broadcasts_to :channel
end
