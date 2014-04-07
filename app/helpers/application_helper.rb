module ApplicationHelper
  def grand_total(collection)
    collection.map(&:total).inject(:+)
  end
end
