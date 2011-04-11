class Auditor < ActiveRecord::Observer
  observe :entity, :client, :project, :user, :entity_type, :entity_key

  def after_create(obj)
    add_audit(obj, 'created')
  end

  def after_update(obj)
    add_audit(obj, 'updated')
  end

  def after_destroy(obj)
    add_audit(obj, 'deleted')
  end

  def add_audit(obj, action)
    user = User.current_user
    audit = Audit.new
    audit[:message] = "#{obj.class.to_s} \"#{obj.to_s}\" was #{action}"
    audit[:message] << " by #{user.username}" unless user.nil?
    audit[:model_id] = obj.id unless obj.nil?
    audit[:model_type] = obj.class.to_s unless obj.nil?
    audit[:user_id] = User.current_user.id unless user.nil?
    audit.save
  end

end
