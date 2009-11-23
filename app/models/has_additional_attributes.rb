module HasAdditionalAttributes

  def self.included(base)
#    base.validates_presence_of :cellphone
#    base.before_save :parse_cellphone

    base.class_eval do
      class_inheritable_reader(:additional1, :additional2)
    end

    base.send(:include,InstanceMethods)
    base.send(:extend, ClassMethods)
  end

  module InstanceMethods
  end

  module ClassMethods
    def additional_attributes(word_class, *fields)
      [1, 2].each do |side|
        key = "additional#{side}".to_sym
        hash = read_inheritable_attribute(key) || {}
        attributes = hash[word_class] || []
        attributes += fields.collect{|f| "#{f}#{side}".to_sym}
        write_inheritable_hash(key, word_class => attributes.uniq)
      end
    end

    def additional_attributes_on_side(side, word_class, *fields)
      key = "additional#{side}".to_sym
      hash = read_inheritable_attribute(key) || {}
      attributes = hash[word_class] || []
      attributes += fields
      write_inheritable_hash(key, word_class => attributes.uniq)
    end
  end
end

