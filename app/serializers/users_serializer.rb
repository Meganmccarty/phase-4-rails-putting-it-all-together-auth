class UsersSerializer < ActiveModel::Serializer
    attributes :id, :username, :image_url, :bio
end
