Rolify::Utils.class_eval do
  type(:deprecate, "(Symbol, Symbol) -> Symbol", {:static => true, :app => true})
end

