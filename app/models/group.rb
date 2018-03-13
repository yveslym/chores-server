class Group < ApplicationRecord
    has_many :chores
    has_and_belongs_to_many :users
    has_attached_file :image_file,
    styles: { medium: "300x300>", thumb: "100x100>" },
    :path => ":attachment/:id/:style.:extension"

    validates_attachment_content_type :image_file, content_type: /\Aimage\/.*\z/

end
