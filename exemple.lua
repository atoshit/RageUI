local mainMenu = RageUI.AddMenu("Exemple Menu", "Démonstration des fonctionnalités")
local submenuItems = RageUI.AddSubMenu(mainMenu, "Items", "Différents types d'items")
local submenuPanels = RageUI.AddSubMenu(mainMenu, "Panels", "Différents types de panels")

local checkboxState = false
local listIndex = 1
local listItems = {"Option 1", "Option 2", "Option 3", "Option 4"}
local sliderValue = 0
local progressSliderValue = 0
local percentageValue = 0.0
local gridX, gridY = 0.5, 0.5
local itemName = "~r~Non défini~w~"
local inputBadge = RageUI.BadgeStyle.Alert
local colorIndex = 1
local colors = {
    {R = 255, G = 0, B = 0, name = "Rouge"},
    {R = 0, G = 255, B = 0, name = "Vert"},
    {R = 0, G = 0, B = 255, name = "Bleu"},
    {R = 255, G = 255, B = 0, name = "Jaune"},
    {R = 255, G = 0, B = 255, name = "Magenta"},
    {R = 0, G = 255, B = 255, name = "Cyan"},
    {R = 255, G = 128, B = 0, name = "Orange"},
    {R = 128, G = 0, B = 255, name = "Violet"},
    {R = 255, G = 255, B = 255, name = "Blanc"},
    {R = 0, G = 0, B = 0, name = "Noir"},
    {R = 128, G = 128, B = 128, name = "Gris"},
    {R = 255, G = 165, B = 0, name = "Orange clair"},
    {R = 255, G = 0, B = 0, name = "Rouge"},
    {R = 0, G = 255, B = 0, name = "Vert"},
    {R = 0, G = 0, B = 255, name = "Bleu"},
    {R = 255, G = 255, B = 0, name = "Jaune"},
    {R = 255, G = 0, B = 255, name = "Magenta"},
    {R = 0, G = 255, B = 255, name = "Cyan"},
    {R = 255, G = 128, B = 0, name = "Orange"},
    {R = 128, G = 0, B = 255, name = "Violet"},
    {R = 255, G = 255, B = 255, name = "Blanc"},
    {R = 0, G = 0, B = 0, name = "Noir"},
    {R = 128, G = 128, B = 128, name = "Gris"},
    {R = 255, G = 165, B = 0, name = "Orange clair"}
}

mainMenu:IsVisible(function(Items)
    
    Items:Separator("--- Navigation ---")

    Items:Button("Menu des Items", "Voir tous les types d'items disponibles", {}, true, {}, submenuItems)
    
    Items:Button("Menu des Panels", "Voir tous les types de panels disponibles", { 
        --RightLabel = "→→→",
        LeftBadge = RageUI.BadgeStyle.Star
    }, true, {}, submenuPanels)

    Items:Separator("--- Actions Rapides ---")

    Items:Button("Afficher une notification", nil, { Color = { Background = { 255, 0, 0, 100 } } }, true, {
        onSelected = function()
            print("Bouton cliqué !")
        end
    })

    Items:Input("Nom de l'objet", "Entrez le nom de l'objet que vous souhaitez créer", {
        RightLabel = itemName,
        LeftBadge = inputBadge,
    }, true, {
        onInput = function(result)
            if result ~= nil then
                print("Texte saisi : " .. result)
                itemName = result
                inputBadge = RageUI.BadgeStyle.Tick
            end
        end
    })


    Items:Button("Fermer le menu", nil, { RightBadge = RageUI.BadgeStyle.Lock }, true, {
        onSelected = function()
            mainMenu:Close()
        end
    })

end, function(Panels)
end)

submenuItems:IsVisible(function(Items)
    
    Items:Separator("--- Items Basiques ---")

    Items:Button("Bouton Simple", "Un bouton standard avec une description", {RightBadge = RageUI.BadgeStyle.Weed}, true, {
        onSelected = function()
            print("Bouton simple sélectionné")
        end
    })

    Items:Checkbox("Checkbox", "Une case à cocher", checkboxState, { Style = RageUI.CheckboxStyle.Tick }, {
        onSelected = function(Checked)
            checkboxState = Checked
            print("Checkbox état: " .. tostring(Checked))
        end
    })

    Items:List("Liste", listItems, listIndex, "Sélectionnez une option dans la liste", {}, true, {
        onListChange = function(Index, Item)
            listIndex = Index
        end,
        onSelected = function(Index, Item)
            print("Option sélectionnée: " .. Item)
        end
    })


    Items:Line()

    Items:Slider("Slider Classique", sliderValue, 10, "Un slider de 1 à 10", false, {}, true, {
        onSliderChange = function(Index)
            sliderValue = Index
        end
    })

    Items:SliderProgress("Slider Progress", progressSliderValue, 20, "Un slider avec barre de progression", {
        ProgressColor = { 255, 0, 0, 255 },
        ProgressBackgroundColor = { 0, 0, 0, 150 }
    }, true, {
        onSliderChange = function(Index)
            progressSliderValue = Index
            print("Slider Progress: " .. Index)
        end
    })

end, function(Panels)
end)

submenuPanels:IsVisible(function(Items)

    Items:Button("Panel Couleur", nil, {}, true, {})
    Items:Button("Panel Grid (Position)", nil, {}, true, {})
    Items:Button("Panel Pourcentage", nil, {}, true, {})
    Items:Button("Panel Statistiques", nil, {}, true, {})
    Items:Button("Panel Info", nil, {}, true, {})

end, function(Panels)
    
    local currentMenu = RageUI.CurrentMenu
    if not currentMenu then return end

    if currentMenu.Index == 1 then
        submenuPanels.EnableMouse = true
        Panels:ColourPanel("Sélection de Couleur", colors, 1, colorIndex, {
            onColorChange = function(Index)
                colorIndex = Index
                print("Couleur sélectionnée: " .. colors[Index].name)
            end
        }, 1)
    
    elseif currentMenu.Index == 2 then
        submenuPanels.EnableMouse = true
        Panels:Grid(gridX, gridY, "Haut", "Bas", "Gauche", "Droite", {
            onPositionChange = function(X, Y, X2, Y2)
                gridX, gridY = X, Y
            end
        }, 2)

    elseif currentMenu.Index == 3 then
        submenuPanels.EnableMouse = true
        Panels:PercentagePanel(percentageValue, "Opacité", "0%", "100%", {
            onProgressChange = function(Percent)
                percentageValue = Percent
            end
        }, 3)

    elseif currentMenu.Index == 4 then
        submenuPanels.EnableMouse = false
        Panels:StatisticPanel(0.8, "Force", 4)
        Panels:StatisticPanel(0.4, "Agilité", 4)
        Panels:StatisticPanelAdvanced("Endurance", 0.6, {255, 0, 0, 255}, 0.2, {0, 255, 0, 255}, {0, 0, 0, 255}, 4)

    elseif currentMenu.Index == 5 then
        submenuPanels.EnableMouse = false
        Panels:info("Détails du Compte", 
            {"Nom:", "Niveau:", "Argent:"}, 
            {"Lenny", "100", "$1,000,000"}, 
            5)
    end

    --Panels:BoutonPanel("Version", "1.0.0")

end)

local function OpenExempleMenu()
    mainMenu:Toggle() 
end

RegisterCommand("exemplemenu", function()
    OpenExempleMenu()
end, false)

RegisterKeyMapping("exemplemenu", "Ouvrir le menu d'exemple", "keyboard", "F1")