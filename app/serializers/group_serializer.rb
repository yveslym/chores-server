class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_file
  def image_file_url
    object.image_file.url()
  end
end
