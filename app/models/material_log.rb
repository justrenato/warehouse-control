class MaterialLog < ApplicationRecord
  belongs_to :user
  belongs_to :material

  validates :action, inclusion: { in: %w[add remove], message: "%{value} is not a valid action" }

  def action_text
    action == 'add' ? 'Entrada' : 'Retirada'
  end
end
