require "rolify/finders"
require "rolify/utils"

module Rolify
  module Role
    extend Utils

    def self.included(base)
      base.extend Finders
    end

    def add_role(role_name, resource = nil)
      role = self.class.adapter.rdl_cast("Rolify::Adapter::RoleAdapter").find_or_create_by(role_name.to_s,
                                                  (resource.is_a?(Class) ? resource.to_s : resource.class.name if resource),
                                                  (resource.rdl_cast("ActiveRecord::Base").id if resource && !resource.is_a?(Class)))

#      role = self.class.adapter.find_or_create_by(role_name.to_s,
#                                                  (resource.is_a?(Class) ? resource.to_s : resource.class.name if resource),
#                                                  (resource.id if resource && !resource.is_a?(Class)))

      if !roles.include?(role)
        self.class.define_dynamic_method(role_name, resource) if Rolify.dynamic_shortcuts
#        self.class.adapter.add(self, role)
        self.class.adapter.rdl_cast("Rolify::Adapter::RoleAdapter").add(self, role)
      end

      role
    end
    alias_method :grant, :add_role

    def has_role?(role_name, resource = nil)
      if new_record?
        role_array = self.roles.detect { |r| r.name.to_s == role_name.to_s && (r.resource == resource || resource.nil?) }
      else
#        role_array = self.class.adapter.where(self.roles, name: role_name, resource: resource)
# NOTE
        role_array = self.class.adapter.rdl_cast("Rolify::Adapter::RoleAdapter").where(self.roles, {:name => role_name, :resource => resource})
      end

      return false if role_array.nil?
      role_array != []
    end

    def has_all_roles?(*args)
      args.each do |arg|
        if arg.is_a? Hash
#          return false if !self.has_role?(arg[:name], arg[:resource])
          arg = arg.rdl_cast("Hash<:name or :resource, String or Symbol or ActiveRecord::Base or Class<ActiveRecord::Base>>")
          return false if !self.has_role?(arg[:name].rdl_cast("String or Symbol"), arg[:resource].rdl_cast("ActiveRecord::Base or Class<ActiveRecord::Base>"))
        elsif arg.is_a?(String) || arg.is_a?(Symbol)
#          return false if !self.has_role?(arg)
          return false if !self.has_role?(arg.rdl_cast("String or Symbol"))
        else
          raise ArgumentError, "Invalid argument type: only hash or string or symbol allowed"
        end
      end
      true
    end

    def has_any_role?(*args)
      if new_record?
        args.any? { |r| self.has_role?(r) }
      else
#        self.class.adapter.where(self.roles, *args).size > 0
        self.class.adapter.rdl_cast("Rolify::Adapter::RoleAdapter").where(self.roles, *args).size > 0
      end
    end

    def only_has_role?(role_name, resource = nil)
      return self.has_role?(role_name,resource) && self.roles.count == 1
    end

    def remove_role(role_name, resource = nil)
      self.class.adapter.rdl_cast("Rolify::Adapter::RoleAdapter").remove(self, role_name.to_s, resource)
    end

    alias_method :revoke, :remove_role
    deprecate :has_no_role, :remove_role

    def roles_name
      self.roles.select(:name).map { |r| r.name }
    end

    def method_missing(method, *args, &block)
      if method.to_s.match(/^is_(\w+)_of[?]$/) || method.to_s.match(/^is_(\w+)[?]$/)
        resource = args.first
#        self.class.define_dynamic_method $1, resource
        self.class.define_dynamic_method $1, resource.rdl_cast("Class<ActiveRecord::Base> or ActiveRecord::Base")
        return has_role?("#{$1}", resource)
      end unless !Rolify.dynamic_shortcuts
      super
    end

    def respond_to?(method, include_private = false)
      if Rolify.dynamic_shortcuts && (method.to_s.match(/^is_(\w+)_of[?]$/) || method.to_s.match(/^is_(\w+)[?]$/))
        query = self.class.role_class.where(:name => $1)
        query = self.class.adapter.exists?(query, :resource_type) if method.to_s.match(/^is_(\w+)_of[?]$/)
        return true if query.count > 0
        false
      else
        super
      end
    end
  end
end

#####################################################
cwd = File.expand_path("..", __FILE__)
require "#{cwd}/../../typesigs/rolify/role_typesigs.rb"
#require "#{cwd}/../../typesigs/rolify/adapters/role_adapter_typesigs.rb"
require_relative '../cfg_pre.rb'
RDL::CFG.preprocess __FILE__
