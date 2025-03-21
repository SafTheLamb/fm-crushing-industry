if not CrushingIndustry then
  CrushingIndustry = {}

  function CrushingIndustry.make_crushing_icons(item_name)
    local item = data.raw.item[item_name]
    local icons = {}
    if item then
      if item.icons then
        icons = table.deepcopy(item.icons)
        icons[#icons + 1] = {icon="__crushing-industry__/graphics/icons/generic-crushing.png"}
      else
        return {
          {icon=item.icon, icon_size=item.icon_size, shift={0, -3}, scale=0.4},
          {icon="__crushing-industry__/graphics/icons/generic-crushing.png"}
        }
      end
    end
    return icons
  end
end
