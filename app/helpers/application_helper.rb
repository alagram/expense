module ApplicationHelper
  def calculate_total(collection)
    collection.map(&:price).inject(:+) if collection.present?
  end
end
