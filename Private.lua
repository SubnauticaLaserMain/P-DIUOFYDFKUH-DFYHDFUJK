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


        
        local RobloxStorage = new('Folder', MainFolder)
        RobloxStorage.Name = 'Roblox-Storage'


        local Chat_Roblox_Module = new('ModuleScript', RobloxStorage)
        Chat_Roblox_Module.Name = 'ChatModule'


        
        local IsNewChatModule = new('ModuleScript', Chat_Roblox_Module)
        IsNewChatModule.Name = 'Is-Latest-Chat_Module'
        Modules[IsNewChatModule] = {
            ['Closure'] = function()
                local script = IsNewChatModule
                local TextChatService = game:GetService('TextChatService')
                

                local IsNewChat = TextChatService.ChatVersion == Enum.ChatVersion.TextChatService



                return IsNewChat
            end
        }

        local ChatModules = new('ModuleScript', Chat_Roblox_Module)
        ChatModules.Name = 'ChatModules'
        Modules[ChatModules] = {
            ['Closure'] = function()
                local script = ChatModules
                local ReplicatedStorage = game:GetService('ReplicatedStorage')
                local TextChatService = game:GetService('TextChatService')
                local StarterGui = game:GetService('StarterGui')
                local ChatService = game:GetService('Chat')

                local IsNewChat = require(script.Parent['Is-Latest-Chat_Module'])


                local ChatModules = {}


                function ChatModules:SendMessage(Message)
                    if IsNewChat then
                        local TextChannels = TextChatService:FindFirstChild('TextChannels')

                        if TextChannels then
                            local RBXGeneral = TextChannels:FindFirstChild('RBXGeneral')


                            if RBXGeneral then
                                RBXGeneral:DisplaySystemMessage(Message)
                            end
                        end
                    else
                        StarterGui:SetCore('ChatMakeSystemMessage', {
                            Text = Message
                        })
                    end
                end

                function ChatModules:SendPlayerMessage(Message)
                    if IsNewChat then
                        TextChatService.ChatInputBarConfiguration.TargetTextChannel:FireServer(Message)
                    else
                        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Message, 'All')
                    end
                end


                return ChatModules
            end
        }



        Modules[Chat_Roblox_Module] = {
            ['Closure'] = function()
                local script = Chat_Roblox_Module
                local ChatService = require(script['ChatModules'])

                local ChatServic = {}


                ChatService:SendPlayerMessage('XD')


                return ChatServic
            end
        }









        local ESPScript = new('LocalScript', PlayersScriptsFolder)
        ESPScript.Name = 'ESP-Script'

        local function ESPScript_Source()
            local script = ESPScript
            local PlayerService = require(script.Parent['Player-Events'])
            require(game.CoreGui['ServerScriptAPI-Source-MainFolder']['Roblox-Storage'].ChatModules)


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
                    local a = new('Highlight', Character)
	
                    a.Name = 'ESP-Part'
                    a.Enabled = true
                    a.Adornee = Character
                    a.OutlineColor = Color3.new(1, 1, 1)
                    a.FillTransparency = 1
                    a.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
            end


            PlayerService.PlayerAdding(function(plr)
                local Character = plr.Character or plr.CharacterAdded:Wait()
                local a = new('Highlight', Character)
	
                a.Name = 'ESP-Part'
                a.Enabled = true
                a.Adornee = Character
                a.OutlineColor = Color3.new(1, 1, 1)
                a.FillTransparency = 1
                a.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
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


