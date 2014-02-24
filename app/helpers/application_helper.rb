module ApplicationHelper
  def calculate_total(collection)
    collection.map(&:price).inject(:+)
  end
end
