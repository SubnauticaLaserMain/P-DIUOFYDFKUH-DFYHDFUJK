local CorePackages = game:GetService('CorePackages')
local CoreGui = game:GetService('CoreGui')




local Modules = {}
local REAL_REQUIRE = require
local function require(Module: ModuleScript)
    local ModuleState = Modules[Module]

    if ModuleState then
        if not ModuleState.Required then
            ModuleState.Required = true
            ModuleState.Value = ModuleState.Closure()
        end

        return ModuleState.Value
    end

    return REAL_REQUIRE(Module)
end


local function new(type, Parent)
    if type then
        if Parent then
            return Instance.new(type, Parent)
        else
            return Instance.new(type)
        end
    end
end



local function MakeFoldersAndScripts()
    if not CoreGui:FindFirstChild('ServerScriptAPI-Source-MainFolder') then
        local MainFolder = new('Folder', CoreGui)
        local PlayersScriptsFolder = new('Folder', MainFolder)


        MainFolder.Name = 'ServerScriptAPI-Source-MainFolder'
        PlayersScriptsFolder.Name = 'Players-Scripts-Folder'
        

        

        local PlayerEvent_Modules = new('ModuleScript', PlayersScriptsFolder)
        PlayerEvent_Modules.Name = 'Player-Events'
        Modules[PlayerEvent_Modules] = {
            ['Closure'] = function()
                local script = PlayerEvent_Modules
                local PlayerService = game:GetService('Players')



                local PlayerEvents_Module = {}



                PlayerEvents_Module.PlayerAdding = function(func)
                    return PlayerService.PlayerAdded:Connect(func)
                end

                PlayerEvents_Module.PlayerRemoved = function(func)
                    return PlayerService.PlayerRemoving:Connect(func)
                end

                PlayerEvents_Module.GetPlayers = function()
                    return PlayerService:GetPlayers()
                end


                PlayerEvents_Module.LocalPlayer = PlayerService.LocalPlayer



                return PlayerEvents_Module
            end
        }
        



        local ESPScript = new('LocalScript', PlayersScriptsFolder)
        ESPScript.Name = 'ESP-Script'

        local function ESPScript_Source()
            local script = ESPScript
            local PlayerService = require(script.Parent['Player-Events'])


            local function new(type, Parent)
                if type then
                    if Parent then
                        return Instance.new(type, Parent)
                    else
                        return Instance.new(type)
                    end
                end
            end





            for count, Player in pairs(PlayerService.GetPlayers()) do
                if not Player:FindFirstChild('ESP-Part') then
                    local Character = Player.Character or Player.CharacterAdded:Wait()
                    local ESP_Part = new('Highlight', Character)

                    ESP_Part.Name = 'ESP-Part'
                    ESP_Part.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    ESP_Part.FillColor = Color3.new(1, 1, 1)
                    ESP_Part.Enabled = true
                    ESP_Part.FillTransparency = 1
                    ESP_Part.OutlineColor = Color3.new(1, 1, 1)
                    ESP_Part.OutlineTransparency = 0
                    ESP_Part.LineThickness = 0.5
                end
            end


            PlayerService.PlayerAdding(function(plr)
                local Character = plr.Character or plr.CharacterAdded:Wait()
                local ESP_Part = new('Highlight', Character)

                ESP_Part.Name = 'ESP-Part'
                ESP_Part.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                ESP_Part.FillColor = Color3.new(1, 1, 1)
                ESP_Part.Enabled = true
                ESP_Part.FillTransparency = 1
                ESP_Part.OutlineColor = Color3.new(1, 1, 1)
                ESP_Part.OutlineTransparency = 0
                ESP_Part.LineThickness = 0.5
            end)

            PlayerService.PlayerRemoved(function(plr)
                if plr.Character:FindFirstChild('ESP-Part') then
                    local Character = plr.Character or plr.CharacterAdded:Wait()

                    Character['ESP-Part']:Destroy()
                end
            end)
        end


        task.spawn(ESPScript_Source)
    end
end

MakeFoldersAndScripts()
