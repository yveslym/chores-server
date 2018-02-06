class Group < ApplicationRecord
    has_many :chores
    has_many :users
   # belongs_to :owner, class_name: :'User'
end
