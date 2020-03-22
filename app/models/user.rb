class User < ApplicationRecord
  validates :name, presence: true, length: { in: 2..200 }
  validates_uniqueness_of :email
  validates_date :date_of_birth, presence: true

  def birthday?
    date_of_birth == Date.today
  end

  def send_registration_email
    UserMailer.registration(self).deliver
  end
end
