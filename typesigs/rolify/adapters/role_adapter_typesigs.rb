Rolify::Adapter::RoleAdapter.class_eval do
  type(:add, "(Rolify::Role, Role) -> Array<Fixnum>", {:app => true})
  type(:remove, "(Rolify::Role, String, ?ActiveRecord::Base or Class<ActiveRecord::Base>) -> ActiveRecord::Relation<Role>", {:app => true})
  type(:where, "(*%any) -> ActiveRecord::Relation<Role>", {:app => true})
  type(:find_or_create_by, "(String, ?String, ?Fixnum) -> Role", {:app => true})
end

