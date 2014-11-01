jQuery ->
  $('#item_shop_name').autocomplete
    source: $('#item_shop_name').data('autocomplete-source')
