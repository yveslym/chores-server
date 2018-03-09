class UserSerializer < ActiveModel::Serializer
  attributes :email,:password, :password_confirmation,:first_name, :last_name,:username, :image_file

  def image_file_url
    object.image_file.url()
  end
end
