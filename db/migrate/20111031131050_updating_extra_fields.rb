class UpdatingExtraFields < ActiveRecord::Migration
  def up
    migre_one("Domain", "Host", "Interval", "Protocol", "Service", "Status")
    migre_two("Queued", "StatusChange")
  end
  
  def migre_one(*models)
    models.each do |model|
      objects = model.constantize.order("created_at ASC")
      objects.each do |object|
        if object.enabled == true
          model.constantize.update(object.id, :published => true, :published_at => object.created_at)
        elsif object.enabled == false
          model.constantize.update(object.id, :published => false, :published_at => object.created_at, :deleted_at => object.updated_at)
        end
        check_unless_error(object)
      end unless objects.empty?
    end
  end
  
  def migre_two(*models)
    models.each do |model|
      objects = model.constantize.order("created_at ASC")
      objects.each do |object|
        model.constantize.update(object.id, :published => true, :published_at => object.created_at, :enabled => true)
        check_unless_error(object)
      end unless objects.empty?
    end
  end
  
  def check_unless_error(object)
    object.save
    unless object.errors.empty?      
      puts "Errors ================== #{object.errors.inspect} =================="
    end
  end
  
end
