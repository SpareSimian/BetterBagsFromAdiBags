local addonName, addon = ...
LibStub('AceAddon-3.0'):NewAddon(addon, addonName, 'AceConsole-3.0')

local bb = LibStub('AceAddon-3.0'):GetAddon("BetterBags")
if not bb then
   addon:Print("BetterBags not loaded!")
   return
end

local categories = bb:GetModule('Categories')
local L = bb:GetModule('Localization')

local adi = LibStub('AceAddon-3.0'):GetAddon("AdiBags")
if not adi then
   addon:Print("AdiBags not loaded!")
   return
end

-- define slash command to do the import

SLASH_BBFADI1="/bbfadi"
SlashCmdList["BBFADI"] = function(msg)

local adiProfile = adi.db.sv.namespaces.FilterOverride.profiles.Default

if adiProfile.version < 2 then
   addon:Print("Old AdiBags, must have version 3 profiles!")
   return
end

local adiOverrides = adiProfile.overrides

for itemId, key in pairs(adiOverrides) do
   local name, category = adi.SplitSectionKey(key)
   if not name then
      addon:Print("nil category for item " .. itemId)
      return
   end
   local _, link = GetItemInfo(itemId)
   local text = link or itemId
   addon:Print("Adding to category " .. name .. ": " .. text)
   categories:AddItemToCategory(itemId, L:G(name))
end

end
