module ApplicationHelper
  def grand_total(collection)
    collection.map(&:price).inject(:+)
  end
end
