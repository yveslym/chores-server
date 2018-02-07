class Group < ApplicationRecord
    has_many :chores
    has_and_belongs_to_many :users
   # belongs_to :owner, class_name: :'User'
end
