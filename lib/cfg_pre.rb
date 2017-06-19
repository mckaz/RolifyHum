require 'rdl'

std_classes = [BasicObject,
               Complex,
               Enumerable,
               Float,
               Kernel,
               Object,
               Range,
               String,
#               Abbrev,
#               Benchmark,
#               Coverage,
               Enumerator,
               Hash,
               MatchData,
               Pathname,
               Rational,
               Symbol,
               Array,
#               BigDecimal,
               Dir,
               File,
               File::Stat,
               Integer,
               Math,
               Process,
               Regexp,
               Time,
#               Base64,
#               BigMath,
               Encoding,
               Fixnum,
               IO,
               Numeric,
               Random,
               Set,
#               ActiveModel::Errors,
#               ActiveRecord::Base,
#               ActiveSupport::TaggedLogging,
#               ActiveSupport::TimeWithZone,
#               ActiveSupport::TimeZone,
#               ActiveRecord::Relation
              ]

std_classes.each {|c|
  RDL.config {|config| config.add_nowrap(c, c.singleton_class)}
}

require 'rdl_types'
require 'rdl_cfg'
