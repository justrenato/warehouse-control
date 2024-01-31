class Material < ApplicationRecord
  before_create :set_was_manual_updated
  after_initialize :set_defaults, unless: :persisted?
  validates :name, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }


  def add_quantity(amount, user)
    return 'isnt_working_day' unless within_business_hours?
    if update(quantity: quantity + amount, was_manual_updated: true)
      log('add', amount, user)
      true
    else
      false
    end
  end

  def remove_quantity(amount, user)
    return 'isnt_working_day' unless within_business_hours?
    return false unless quantity >= amount
    if quantity >= amount && update(quantity: quantity - amount, was_manual_updated: true)
      log('remove', amount, user)
      true
    else
      false
    end
  end

  private

  def set_was_manual_updated
    self.was_manual_updated = false
  end

  def log(action, amount, user)
    new_log = MaterialLog.new({
        user_id: user.id,
        material_id: self.id,
        amount: amount,
        action: action,
      })
    new_log.save
  end

  def within_business_hours?
    current_time = Time.zone.now
    is_weekday = (1..5).cover?(current_time.wday)
    is_business_hours = (current_time.hour >= 9 && current_time.hour < 18)

    is_weekday && is_business_hours
  end

  def set_defaults
    self.quantity ||= 0
  end
end
