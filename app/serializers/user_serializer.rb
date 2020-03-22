class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :date_of_birth, :today_have_birthday

  def today_have_birthday
    object.birthday?
  end

  def date_of_birth
    object.date_of_birth.in_time_zone('UTC').iso8601(6)
  end

end
