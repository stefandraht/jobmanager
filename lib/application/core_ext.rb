class Hash
  def symbolize_keys!
    t=self.dup
    self.clear
    t.each_pair do |k,v|
      if v.kind_of?(Hash)
        v.symbolize_keys!
      end
      self[k.to_sym] = v
      self
    end
    self
  end
end


class Array
  def clip n=1
    take size - n
  end
end