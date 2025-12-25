---@type table
local Colour = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 112 },
    LeftArrow = { Dictionary = "commonmenu", Texture = "arrowleft", X = 7.5, Y = 15, Width = 30, Height = 30 },
    RightArrow = { Dictionary = "commonmenu", Texture = "arrowright", X = 393.5, Y = 15, Width = 30, Height = 30 },
    Header = { X = 215.5, Y = 15, Scale = 0.35 },
    Box = { X = 15, Y = 55, Width = 42.5, Height = 42.5 },
    SelectedRectangle = { X = 15, Y = 47, Width = 42.5, Height = 8 },
    Seperator = { Text = "/" }
}

---ColourPanel
---@param Title string
---@param Colours thread
---@param MinimumIndex number
---@param CurrentIndex number
---@param Callback function
---@return nil
---@public
function Panels:ColourPanel(Title, Colours, MinimumIndex, CurrentIndex, Action, Index, Style)

    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;

    if CurrentMenu ~= nil then
        if CurrentMenu and (CurrentMenu.Index == Index) then

            ---@type number
            local Rows = math.ceil(#Colours / 8)
            local HorizontalSpacing = 9
            local VerticalSpacing = 12
            local RowHeight = Colour.Box.Height + VerticalSpacing
            local BackgroundHeight = 65.5 + (Rows * RowHeight)

            ---@type boolean
            local Hovered = (CurrentMenu.Index == Index) and RageUI.IsMouseInBounds(CurrentMenu.X + Colour.Box.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.Box.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, (Colour.Box.Width * 8) + (7 * HorizontalSpacing), RowHeight * Rows) or false

            local _CurrentIndex = CurrentIndex

            RenderSprite(Colour.Background.Dictionary, Colour.Background.Texture, CurrentMenu.X, CurrentMenu.Y + Colour.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.Background.Width + CurrentMenu.WidthOffset, BackgroundHeight, 0, 255, 255, 255, 200)

            for i = 1, #Colours do
                local Row = math.floor((i - 1) / 8)
                local Col = (i - 1) % 8
                local ColorData = Colours[i]
                local X = CurrentMenu.X + Colour.Box.X + (Colour.Box.Width * Col) + (CurrentMenu.WidthOffset / 2) + (Col * HorizontalSpacing)
                local Y = CurrentMenu.Y + Colour.Box.Y + (Row * RowHeight) + CurrentMenu.SubtitleHeight + RageUI.ItemOffset

                if i == _CurrentIndex then
                    RenderRectangle(X, Y - 8, Colour.SelectedRectangle.Width, Colour.SelectedRectangle.Height, 245, 245, 245, 255)
                end

                if ColorData then
                    if ColorData.R and ColorData.G and ColorData.B then
                        RenderRectangle(X, Y, Colour.Box.Width, Colour.Box.Height, ColorData.R, ColorData.G, ColorData.B, ColorData.A or 255)
                    elseif ColorData[1] and ColorData[2] and ColorData[3] then
                        RenderRectangle(X, Y, Colour.Box.Width, Colour.Box.Height, ColorData[1], ColorData[2], ColorData[3], ColorData[4] or 255)
                    else
                        RenderRectangle(X, Y, Colour.Box.Width, Colour.Box.Height, 255, 255, 255, 255)
                    end
                end
            end
            
            local ColourSeperator = {}
            if type(Style) == "table" then
                if type(Style.Seperator) == "table" then
                    ColourSeperator = Style.Seperator
                else
                    ColourSeperator = Colour.Seperator
                end
            else
                ColourSeperator = Colour.Seperator
            end
            
            RenderText((Title and Title or "") .. " (" .. _CurrentIndex .. " " .. ColourSeperator.Text .. " " .. #Colours .. ")", CurrentMenu.X + RageUI.Settings.Panels.Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Grid.Text.Top.Scale, 245, 245, 245, 255, 1)

            if (CurrentMenu.Index == Index) then
                local Change = false
                if Hovered and RageUI.Settings.Controls.Click.Active then
                    for i = 1, #Colours do
                        local Row = math.floor((i - 1) / 8)
                        local Col = (i - 1) % 8
                        local X = CurrentMenu.X + Colour.Box.X + (Colour.Box.Width * Col) + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2) + (Col * HorizontalSpacing)
                        local Y = CurrentMenu.Y + Colour.Box.Y + (Row * RowHeight) + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset
                        if (CurrentMenu.Index == Index) and RageUI.IsMouseInBounds(X, Y, Colour.Box.Width, Colour.Box.Height) then
                            _CurrentIndex = i
                            Change = true
                        end
                    end
                end

                if Change then
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].Slider.audioName, Audio[Audio.Use].Slider.audioRef, true)
                    if (Action.onColorChange ~= nil) then
                        Action.onColorChange(_CurrentIndex, 1)
                    end
                    if (Action.onIndexChange ~= nil) then
                        Action.onIndexChange(_CurrentIndex, 1)
                    end
                    RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
                end
            end

            RageUI.ItemOffset = RageUI.ItemOffset + BackgroundHeight + Colour.Background.Y
        end
    end
end


