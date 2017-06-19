Rolify::Dynamic.class_eval do
  type(:define_dynamic_method, "(String or Symbol, Class<ActiveRecord::Base> or ActiveRecord::Base) -> Proc or Symbol", {:static => true, :app => true})
  type(:load_dynamic_methods, "() -> Array<Role>", {:static => true, :app => true})

  pre :define_dynamic_method do |role_name, resource|
    type("is_#{role_name}?".to_sym, "() -> %bool", {:static => true, :dyn => true})
    type("is_#{role_name}_of?".to_sym, "(Class<ActiveRecord::Base> or ActiveRecord::Base) -> %bool", {:static => true, :dyn => true})
    true
  end
end
