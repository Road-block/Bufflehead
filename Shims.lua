local MOD = Bufflehead
local SHIM = MOD.SHIM
local UnitAura = UnitAura

-- C_Addons
function SHIM:LoadAddOn(name)
	if _G.C_AddOns.LoadAddOn ~= nil then
		return C_AddOns.LoadAddOn(name)
	end

	return LoadAddOn(name)
end

-- C_UnitAuras
function SHIM:UnitAura(unitToken, index, filter)
    if _G.C_UnitAuras.GetAuraDataByIndex ~= nil then
        local info = C_UnitAuras.GetAuraDataByIndex(unitToken, index, filter)

        if info == nil then
            return nil
        end

        return info.name,
            info.icon,
            info.applications,
            info.dispelName,
            info.duration,
            info.expirationTime
    end

    return UnitAura(unitToken, index, filter)
end

-- DebuffTypeColor
SHIM.DebuffTypeColor = {}
if AuraUtil and AuraUtil.GetDebuffDisplayInfoTable then
    local debuffDisplayInfoTable = AuraUtil.GetDebuffDisplayInfoTable()
    if debuffDisplayInfoTable then
        for debuffType, displayInfo in pairs(debuffDisplayInfoTable) do
            local r,g,b = displayInfo.color:GetRGB()
            SHIM.DebuffTypeColor[debuffType] = {r=r, g=g, b=b}
        end
        if SHIM.DebuffTypeColor["None"] then
            SHIM.DebuffTypeColor[""] = SHIM .DebuffTypeColor["None"]
            SHIM.DebuffTypeColor["none"] = SHIM.DebuffTypeColor["None"]
        end
    end
elseif _G.DebuffTypeColor then
    SHIM.DebuffTypeColor = CopyTable(_G.DebuffTypeColor)
end