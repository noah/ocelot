module OCLT

  # Java::OrgOdftoolkitSimpleTextList::List.class_eval do

  #   # look up an execution path for an undefined method
  #   def method_missing(name, *args, &block)
  #     if OCLT::List.respond_to? name
  #       OCLT::List.send name, *args, &block
  #     else
  #       # Set some mappings on a case-by-case basis
  #       puts "Not implemented: `#{self.class} -> #{name}`"
  #     end
  #   end

  # end

  Java::OrgOdftoolkitSimpleTextList::List.class_eval do

    def header name
      self.set_header name
    end

    def to_s
      self.items.inject(self.get_header << "\n") do |s, item|
        s << "#{item}\n"
      end
    end

    def items
      self.get_items
    end

    def [] i
      self.get_item i
    end

    def push el
      if el.class == Array
        el.each{|elt| self.add_item elt.to_s }
      else
        self.add_item el.to_s
      end
    end

    def []= idx, elt
      self.set(idx, elt)
    end

    def delete_at idx
      self.remove_item(idx)
    end
  end

end
