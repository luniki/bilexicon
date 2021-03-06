module HasAdditionalAttributes

  def self.included(base)
    base.before_save :filter_additional_attributes

    base.class_eval do
      class_inheritable_reader(:additional1, :additional2)
    end

    base.send(:include,InstanceMethods)
    base.send(:extend, ClassMethods)
  end

  module InstanceMethods
    def filter_additional_attributes
      remove1 = Lemma.additional1.reject{|key,value| key == self.word_class1.to_sym}.values.flatten.uniq
      remove2 = Lemma.additional2.reject{|key,value| key == self.word_class2.to_sym}.values.flatten.uniq
      (remove1 + remove2).each {|attribute| self[attribute] = nil}
    end

    def additional_attributes(side)
      Lemma.send("additional#{side}")[self["word_class#{side}"].to_sym] || []
    end
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

