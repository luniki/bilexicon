# Copy this file in RAILS_ROOT/config/initializers/awesome_nested_set_helper.rb
module CollectiveIdea::Acts::NestedSet::Helper

  # Like #nested_set_options helper but with only one DB query
  #
  # Returns options for select.
  # You can exclude some items from the tree.
  # You can pass a block receiving an item and returning the string displayed in the select.
  #
  # == Params
  # * +class_or_item+ - Class name or top level times
  # * +mover+ - The item that is being move, used to exclude impossible moves
  # * +&block+ - a block that will be used to display: { |item| ... item.name }
  #
  # == Usage
  #
  # <%= f.select :parent_id, nested_tree_options(Category, @category) {|i, level|
  #   "#{'-' * level} #{i.name}"
  # }) %>
  #
  def nested_tree_options(class_or_item, mover = nil)
    result = []
    items = Array( class_or_item.is_a?(Class) ? class_or_item.roots : class_or_item )
    items.each do |item|
      result << [yield(item, 0), item.id]
      unless item.leaf?
        item.class.each_with_level(item.descendants) do |i, level|
          if mover.nil? || mover.new_record? || mover.move_possible?(i)
            result << [yield(i, level), i.id]
          end
        end
      end
    end
    result
  end

end
