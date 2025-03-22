if not CrushingIndustry then
  CrushingIndustry = {}

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
end
