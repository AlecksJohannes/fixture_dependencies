class << FixtureDependencies
  private
  
  def add_associated_object_S(reflection, attr, object, assoc)
    if reflection[:type] == :one_to_one
      object.send("#{reflection[:name]}=", assoc)
    else
      object.send("add_#{attr.to_s.singularize}", assoc) unless object.send(attr).include?(assoc)
    end
  end
  
  def model_find_S(model, pk)
    model[pk] || raise(Sequel::Error)
  end
  
  def model_find_by_pk_S(model, pk)
    model[pk]
  end
  
  def model_save_S(object)
    object.raise_on_save_failure = true
    object.save
  end
  
  def raise_model_error_S(message)
    raise Sequel::Error, message
  end
  
  def reflection_S(model, attr)
    model.association_reflection(attr)
  end
  
  def reflection_class_S(reflection)
    reflection.associated_class
  end
  
  def reflection_key_S(reflection)
    reflection[:key]
  end
  
  def reflection_type_S(reflection)
    reflection[:type]
  end
end
