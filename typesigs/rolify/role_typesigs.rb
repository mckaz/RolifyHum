module Rolify::Role
#Rolify::Role.class_eval do
  type(:add_role, "(String or Symbol, ?ActiveRecord::Base or Class<ActiveRecord::Base>) -> Role", {:static => true, :app => true})
  type(:has_role?, "(String or Symbol, ?ActiveRecord::Base or Class<ActiveRecord::Base>) -> %bool", {:static => true, :app => true})
  type(:has_all_roles?, "(*String or Symbol or Hash<:name or :resource, String or Symbol or ActiveRecord::Base or Class<ActiveRecord::Base>>) -> %bool", {:static => true, :app => true})
  type(:has_any_role?, "(*String or Symbol) -> %bool", {:static => true, :app => true})
  type(:only_has_role?, "(String or Symbol, ?ActiveRecord::Base or Class<ActiveRecord::Base>) -> %bool", {:static => true, :app => true})
  type(:remove_role, "(String or Symbol, ?ActiveRecord::Base or Class<ActiveRecord::Base>) -> ActiveRecord::Relation<Role>", {:static => true, :app => true})
  type(:roles_name, "() -> Array<String>", {:static => true, :app => true})
  type(:method_missing, "(Symbol, *%any) -> %any", {:static => true, :app => true})

  type(:roles, "() -> Array<Role>", {:nocheck => true, :app => true})
end

