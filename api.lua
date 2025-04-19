if not CrushingIndustry then
  CrushingIndustry = {
    concrete_items = {},
    concrete_recipes = {},
    FLAVOR_BYPRODUCT = 0.02,
    STANDARD_BYPRODUCT = 0.05,
    COMMON_BYPRODUCT = 0.15,
    FREQUENT_BYPRODUCT = 0.35
  }

  function CrushingIndustry.make_crushing_icons(item_name_or_path)
    local image_icon, item
    item = data.raw.item[item_name_or_path]
    if item then
      if item.icons then
        local icons = table.deepcopy(item.icons)
        icons[#icons + 1] = {icon="__crushing-industry__/graphics/icons/generic-crushing.png"}
        return icons
      else
	      image_icon = item.icon
      end
	  else
      image_icon = item_name_or_path
    end
    return {
      {icon=image_icon, icon_size=(item and item.icon_size) or 64, shift={0, -3}, scale=0.4},
      {icon="__crushing-industry__/graphics/icons/generic-crushing.png"}
    }
  end

  function CrushingIndustry.make_crushing_byproduct(item_name, probability, amount, allow_productivity)
    amount = amount or 1
    return {
      type = "item",
      name = item_name,
      amount = amount,
      probability = probability or CrushingIndustry.STANDARD_BYPRODUCT,
      ignored_by_stats = not allow_productivity and amount or nil,
      ignored_by_productivity = not allow_productivity and amount or nil,
      show_details_in_recipe_tooltip = false
    }
  end
end
