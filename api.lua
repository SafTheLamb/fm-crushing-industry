if not CrushingIndustry then
  CrushingIndustry = {
    concrete_recipes = {},
    FLAVOR_BYPRODUCT = 0.02,
    STANDARD_BYPRODUCT = 0.05,
    COMMON_BYPRODUCT = 0.15
  }

  function CrushingIndustry.make_crushing_icons(item_name, is_filename)
    local image_icon, item
    if is_filename then
      image_icon = item_name
    else
      item = data.raw.item[item_name]
    end
    if item then
      if item.icons then
        local icons = table.deepcopy(item.icons)
        icons[#icons + 1] = {icon="__crushing-industry__/graphics/icons/generic-crushing.png"}
        return icons
      else
	      image_icon = item.icon
      end
	  end
    return {
      {icon=image_icon, icon_size=(item and item.icon_size) or 64, shift={0, -3}, scale=0.4},
      {icon="__crushing-industry__/graphics/icons/generic-crushing.png"}
    }
  end

  function CrushingIndustry.make_crushing_byproduct(item_name, probability, amount)
    return {type="item", name=item_name, amount=amount or 1, probability=probability or CrushingIndustry.STANDARD_BYPRODUCT, ignored_by_stats=1, ignored_by_productivity=1, show_details_in_recipe_tooltip=false}
  end
end
