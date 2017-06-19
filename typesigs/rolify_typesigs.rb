module Rolify
  type(:adapter, "() -> Rolify::Adapter::ResourceAdapter or Rolify::Adapter::RoleAdapter", {:app => true})
  type(:role_class, "() -> Class<Role> or String", {:static => true, :app => true})
  type(:name, "() -> String", {:nocheck => true, :app => true})  
  type(:role_cname, "() -> String", {:nocheck => true, :app => true})  
  
  class << self
    type(:dynamic_shortcuts, "() -> %bool", {:nocheck => true, :app => true})
  end

  type_var(:@adapter, "Rolify::Adapter::ResourceAdapter or Rolify::Adapter::RoleAdapter")
end

