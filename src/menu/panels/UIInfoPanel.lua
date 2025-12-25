--[[
--Created Date: Friday August 26th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Friday August 26th 2022 12:51:40 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

---@param Title string
---@param LeftText table
---@param RightText table
---@param Index number
---@param startAt number
function Panels:info(Title, LeftText, RightText, Index, startAt)
    local CurrentMenu = RageUI.CurrentMenu
    local LineCount = (RightText and LeftText and #LeftText >= #RightText and #LeftText or LeftText and #LeftText) or 1
    if CurrentMenu then
        if (not Index and not startAt) or ((not Index and startAt) and CurrentMenu.Index >= startAt) or ((not startAt and Index) and CurrentMenu.Index == Index) then
            if Title ~= nil then
                RenderText("~h~" .. Title .. "~h~", 330 + 25 + 100, 7, 0, 0.34, 255, 255, 255, 255, 0)
            end
            if LeftText ~= nil then
                RenderText(table.concat(LeftText, "\n"), 330 + 25 + 100, Title ~= nil and 37 or 7, 0, 0.25, 255, 255, 255, 255, 0)
            end
            if RightText ~= nil then
                RenderText(table.concat(RightText, "\n"), 330 + 342 + 80, Title ~= nil and 37 or 7, 0, 0.25, 255, 255, 255, 255, 2)
            end
            RenderSprite("commonmenu", "gradient_bgd", 320 + 15 + 100, 0, 342, Title ~= nil and 50 + (LineCount * 20), 0, 255, 255, 255, 200)
        end
    end
end