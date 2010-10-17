module InstanceEvalAttr
  def instance_eval_attr(*names)
    names.each do |name|
      varname= "@#{name}"
      define_method name do |*args|
        instance_variable_set(varname, args.first) unless args.empty?
        instance_variable_get(varname)
      end
      define_method "#{name}=" do |val|
        instance_variable_set(varname, val)
      end
    end
  end
end
