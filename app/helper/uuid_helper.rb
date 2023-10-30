module UuidHelper
  def self.included(base)
    base.primary_key = 'user_id'
    base.before_create :assign_uuid
  end

  private
  def assign_uuid
    self.user_id = UUIDTools::UUID.timestamp_create().to_s.upcase if user_id.blank?
  end
end
