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
                    return Players:GetPlayers()
                end


                PlayerEvents_Module.LocalPlayer = PlayerService.LocalPlayer



                return PlayerEvents_Module
            end
        }
        



        local ESPScript = new('Script', PlayersScriptsFolder)
        ESPScript.Name = 'ESP-Script'
        ESPScript.RunContext = Enum.RunContext.Client

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
                    local ESP_Part = new('Highlight', Player)

                    ESP_Part.Name = 'ESP-Part'
                    ESP_Part.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    ESP_Part.FillColor = Color3.new(1, 1, 1)
                    ESP_Part.Enabled = true
                    ESP_Part.FillTransparency = 1
                    ESP_Part.OutlineColor = Color3.new(1, 1, 1)
                    ESP_Part.OutlineTransparency = 0
                end
            end


            PlayerService.PlayerAdding(function(plr)
                local ESP_Part = new('Highlight', Player)

                ESP_Part.Name = 'ESP-Part'
                ESP_Part.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                ESP_Part.FillColor = Color3.new(1, 1, 1)
                ESP_Part.Enabled = true
                ESP_Part.FillTransparency = 1
                ESP_Part.OutlineColor = Color3.new(1, 1, 1)
                ESP_Part.OutlineTransparency = 0
            end)

            PlayerService.PlayerRemoved(function(plr)
                if plr:FindFirstChild('ESP-Part') then
                    plr['ESP-Part']:Destroy()
                end
            end)
        end
    end
end
