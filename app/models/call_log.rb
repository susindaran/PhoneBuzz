class CallLog < ApplicationRecord
  validates :number, :delay, presence: true
  validates :number, format: { with: /\A\+1[0-9]{10}\z/, message: ' field has invalid number format.'}
  validates :delay, format: { with: /\A[1-9][0-9]*[smhdwy]\z/, message: ' field has invalid format. Follow the regex provided.' }
end
