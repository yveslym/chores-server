class Chore < ApplicationRecord
    # enum chore_type: [:completed, :in_progress]
    belongs_to :group
    belongs_to :user, optional: :true

end
