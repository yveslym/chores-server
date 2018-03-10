class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :groups#, foreign_key: :owner
  has_many :chores, through: :groups, :autosave => false
  validates :email, presence: true, uniqueness: true
  has_attached_file :image_file, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image_file, content_type: /\Aimage\/.*\z/
end
