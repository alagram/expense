module ApplicationHelper
  def grand_total(collection)
    collection.map(&:total).inject(:+)
  end

  def shop_for_user
    current_user.shops.map { |shop| [shop.name, shop.id] }
  end
end
