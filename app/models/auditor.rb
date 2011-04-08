class Auditor < ActiveRecord::Observer
  observe :entity, :client, :project, :user, :entity_type, :entity_key

  def after_save(obj)
    add_audit(obj, 'created')
  end

  def after_update(obj)
    add_audit(obj, 'updated')
  end

  def after_destroy(obj)
    add_audit(obj, 'deleted')
  end

  def add_audit(obj, action)
    Audit.create(
      :message => "#{obj.class.to_s} \"#{obj.name}\" #{action}.",
      :model_id => obj.id,
      :model_type => obj.class.to_s
    )
  end

end
