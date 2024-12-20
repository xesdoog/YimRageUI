local basePath = 'includes/'
local modules  = {
    'components/vector2',
    'components/vector3',
    'RageUI',
    'Menu',
    'MenuController',
    'components/Audio',
    'components/Visual',
    'components/Graphics',
    'components/Util',
    'components/Keys',
    'elements/ItemsBadge',
    'elements/ItemsColour',
    'elements/PanelColour',
    'items/Items',
    'items/Panels',
}

for _, module in pairs(modules) do
    require(string.format("%s%s", basePath, module))
end
