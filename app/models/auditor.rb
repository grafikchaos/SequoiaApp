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

  # TODO: clean up the Law of Demeter violations with some delegation
  def add_audit(obj, action)
    if Rails.env != 'test'
      user = User.current_user
      audit = Audit.new
      
      case obj.class.to_s
        when 'Entity'
          audit[:message]     = "#{obj.class.to_s} for Client: \"#{obj.project.client.to_s}\" \"#{obj.to_s}\" was #{action}"
        when 'Project'
          audit[:message]     = "#{obj.class.to_s} for Client: \"#{obj.client.to_s}\" \"#{obj.to_s}\" was #{action}"
        else
          audit[:message]     = "#{obj.class.to_s} \"#{obj.to_s}\" was #{action}"
      end
      audit[:message] << " by #{user.username}" unless user.nil?
      audit[:model_id]    = obj.id unless obj.nil?
      audit[:model_type]  = obj.class.to_s unless obj.nil?
      audit[:user_id]     = user.id unless user.nil?
      if obj.respond_to?('versions')
        audit[:version_id]  = obj.versions.last.id unless obj.versions.blank?
      end
      audit.save
    end
  end

end
