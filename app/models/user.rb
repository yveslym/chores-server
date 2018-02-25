class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :groups#, foreign_key: :owner
  has_many :chores, through: :groups, :autosave => false
  validates :email, presence: true, uniqueness: true
end
