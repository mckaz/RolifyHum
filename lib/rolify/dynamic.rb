module Rolify
  module Dynamic
    def load_dynamic_methods
#      self.role_class.all.each do |r|
      self.role_class.rdl_cast("Class<Role>").all.each do |r|
        define_dynamic_method(r.name, r.resource)
      end
    end

    def define_dynamic_method(role_name, resource)
# NOTE Cast because class_eval's ret type is %any
      x = class_eval do 
        define_method("is_#{role_name}?".to_sym) do
          has_role?("#{role_name}")
        end if !method_defined?("is_#{role_name}?".to_sym)

        define_method("is_#{role_name}_of?".to_sym) do |arg|
          has_role?("#{role_name}", arg)
        end if !method_defined?("is_#{role_name}_of?".to_sym) && resource
      end

      x.rdl_cast "Proc or Symbol"
    end
  end
end

########################

cwd = File.expand_path("..", __FILE__)
require "#{cwd}/../../typesigs/rolify/dynamic_typesigs.rb"
RDL::CFG.preprocess __FILE__
