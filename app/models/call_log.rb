class CallLog < ApplicationRecord
  validates :number, :delay, presence: true
end
