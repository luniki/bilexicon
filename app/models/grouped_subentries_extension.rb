module GroupedSubentriesExtension
  def group_by_meaning
    inject(Hash.new {|hash, key| hash[key] = []}) do |hash, element|
      hash[""] << element if element.meanings.length == 0;
      element.meaning_list.each do |m|
        hash[m] << element
      end
      hash
    end.sort_by {|a, b| a == "" ? 0 : -b.length}
  end
end
