local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/UI-Libraries/main/Vynixius/Source.lua"))()


local Window = Library:AddWindow({
    title = {'ServerScriptAPI', 'BETA'},
    theme = {
        Accent = Color3.fromRGB(34, 255, 0)
    },
    key = Enum.KeyCode.RightControl,
	default = true
})



-- Define Tabs
local MainTab = Window:AddTab('Main', {default = false})







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
                        TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(Message)
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


                function ChatServic:SendMessage(Message)
                    ChatService:SendMessage(Message)
                end

                function ChatServic:MakePlayerChat(Message)
                    ChatService:SendPlayerMessage(Message)
                end


                return ChatServic
            end
        }



        local GamesSupportedData = new('Folder', MainFolder)
        GamesSupportedData.Name = 'Games-Supported Data'


        local BreakIn_Datas = new('Folder', GamesSupportedData)
        BreakIn_Datas.Name = 'Break-In-Data'


        local BreakIn1_Data = new('ModuleScript', BreakIn_Datas)
        BreakIn1_Data.Name = 'Break-In-Data'
    


        local BreakIn1_LobbyData = new('ModuleScript', BreakIn1_Data)
        BreakIn1_LobbyData.Name = 'Lobby'

        Modules[BreakIn1_LobbyData] = {
            ['Closure'] = function()
                local Data = {}

                
                Data.EquipRole = function(Role, RoleData)
                    local MakeRole = game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents').MakeRole
                    local OutsideRole = game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents').OutsideRole



                    if Role and RoleData then
                        if Role == 'The Swat' then
                            local RData = {
                                [1] = 'SwatGun',
                                [2] = false,
                                [3] = RoleData.IsUsingSkin
                            }

                            local OutsideData = {
                                [1] = RData[1],
                                [2] = RData[3]
                            }


                            OutsideRole:FireServer(unpack(OutsideData))
                            MakeRole:FireServer(unpack(RData))
                        elseif Role == 'The Officer' then
                            local RData = {
                                [1] = 'Gun',
                                [2] = false,
                                [3] = RoleData.IsUsingSkin
                            }

                            local OutsideData = {
                                [1] = RData[1],
                                [2] = RData[3]
                            }


                            OutsideRole:FireServer(unpack(OutsideData))
                            MakeRole:FireServer(unpack(RData))
                        elseif Role == 'The Medic' then
                            local RData = {
                                [1] = 'MedKit',
                                [2] = false,
                                [3] = RoleData.IsUsingSkin
                            }



                            MakeRole:FireServer(unpack(RData))
                        elseif Role == 'The Protector' then
                            local RData = {
                                [1] = 'Bat',
                                [2] = false,
                                [3] = RoleData.IsUsingSkin
                            }



                            MakeRole:FireServer(unpack(RData))
                        elseif Role == 'The Stealthy' then
                            local RData = {
                                [1] = 'TeddyBloxpin',
                                [2] = true,
                                [3] = RoleData.IsUsingSkin
                            }



                            MakeRole:FireServer(unpack(RData))
                        elseif Role == 'The Hungry' then
                            local RData = {
                                [1] = 'Chips',
                                [2] = true,
                                [3] = RoleData.IsUsingSkin
                            }



                            MakeRole:FireServer(unpack(RData))
                        elseif Role == 'The Fighter' then
                            local RData = {
                                [1] = 'Sword',
                                [2] = true,
                                [3] = RoleData.IsUsingSkin
                            }


                            local OutsideData = {
                                [1] = RData[1],
                                [2] = RData[3]
                            }


                            OutsideRole:FireServer(unpack(OutsideData))
                            MakeRole:FireServer(unpack(RData))
                        end
                    end
                end


                return Data
            end
        }
    




        Modules[BreakIn1_Data] = {
            ['Closure'] = function()
                local Data = {}



                return Data
            end
        }







        local PlayerExtraEventHandler = new('LocalScript', PlayersScriptsFolder)
        PlayerExtraEventHandler.Name = 'Player-Extra-Event Handler'


        local CharacterModule = new('ModuleScript', PlayerExtraEventHandler)
        CharacterModule.Name = 'Character-Module'

        Modules[CharacterModule] = {
            ['Closure'] = function()
                local script = CharacterModule
                local PlayerEvents = require(game.CoreGui['ServerScriptAPI-Source-MainFolder']['Players-Scripts-Folder']['Player-Events'])



                local module = {}


                module.GetCharacter = function()
                    local Player = PlayerEvents.LocalPlayer

                    local Character = Player.Character or Player.CharacterAdded:Wait()



                    if Character then
                        return Character
                    else
                        return nil
                    end
                end


                return module
            end
        }




        local ExtraPlayerData = new('ModuleScript', PlayerExtraEventHandler)
        ExtraPlayerData.Name = 'Extra-Player-Data'

        Modules[ExtraPlayerData] = {
            ['Closure'] = function()
                local script = ExtraPlayerData
                local Character_Module = require(script.Parent['Character-Module'])


                local module = {}


                module.GetHumanoid = function()
                    local Character = Character_Module.GetCharacter()


                    local Humanoid = Character:WaitForChild('Humanoid', 10)


                    if not Humanoid then
                        warn("Humanoid is not in Character. \n\nError on: 'CoreGui.ServerScriptAPI-Source-MainFolder.Players-Scripts-Folder.Player-Extra-Event Handler.Extra-Player-Data', Line 14 Function GetHumanoid\n\n")

                        return
                    end

                    return Humanoid
                end

                module.GetCurrentCamera = function()
                    if workspace and workspace.CurrentCamera and typeof(workspace.CurrentCamera) == 'Camera' then
                        return workspace.CurrentCamera
                    end
                end


                return module
            end
        }



        local function PlayerExtraEventHandler_Source()
            local script = PlayerExtraEventHandler
            local Character_Module = require(script['Character-Module'])
            local Extra_Module = require(script['Extra-Player-Data'])
            local Player_Module = require(game.CoreGui['ServerScriptAPI-Source-MainFolder']['Players-Scripts-Folder']['Player-Events'])
            local ChatService = require(game.CoreGui['ServerScriptAPI-Source-MainFolder']['Roblox-Storage'].ChatModule)


            local Character = Character_Module.GetCharacter()
            local Humanoid = Extra_Module.GetHumanoid()
            local LocalPlayer = Player_Module.LocalPlayer
            local Camera = Extra_Module.GetCurrentCamera()


            LocalPlayer.Chatted:Connect(function(message: string, recipient: Player)
                local Splited = message:split(' ')

                if Splited[1]:lower() == '/speed' then
                    if tonumber(Splited[2]) then
                        Humanoid.WalkSpeed = tonumber(Splited[2])
                        ChatService:SendMessage('Set WalkSpeed To: '..Splited[2])
                    end
                else
                    if Splited[1]:lower() == '/jumpheight' then
                        if tonumber(Splited[2]) then
                            Humanoid.JumpPower = tonumber(Splited[2])
                            ChatService:SendMessage('Set JumpPower To: '..Splited[2])
                        end
                    else
                        if Splited[1]:lower() == '/fov' then
                            if tonumber(Splited[2]) then
                                Camera.FieldOfView = tonumber(Splited[2])
                                ChatService:SendMessage('Set FOV To: '..Splited[2])
                            end
                        end
                    end
                end
            end)
        end

        task.spawn(PlayerExtraEventHandler_Source)




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
                if plr.Character then
                    if plr.Character:FindFirstChild('ESP-Part') then
                        local Character = plr.Character or plr.CharacterAdded:Wait()

                        Character['ESP-Part']:Destroy()
                    end
                end
            end)
        end


        task.spawn(ESPScript_Source)




        local GuiLibrary_Controller = new('Script', MainFolder)
        GuiLibrary_Controller.Name = 'GuiLibrary-Controller'


        local function GuiLibrary_Controller_Source()
            local script = GuiLibrary_Controller


            if CoreGui:FindFirstChild('Vynixius UI Library') then
                CoreGui['Vynixius UI Library'] = script
            end
            


            if game.PlaceId == 3851622790 then
                local BreakInData = require(script.Parent['Games-Supported Data']['Break-In-Data']['Break-In-Data'].Lobby)


                local RolesSection = MainTab:AddSection('Roles', {default = false})


                local RoleSelected = nil
                local RoleCustomeOn = false

                
                RolesSection:AddDropdown('Adults', {'The Protector', 'The Medic', 'The Officer', 'The Swat'}, {default = 'The Protector'}, function(selected)
                    RoleSelected = selected
                end)

                RolesSection:AddToggle('Custome', {flag = 'Toggle_Flag', default = false}, function(On)
                    RoleCustomeOn = On
                end)


                RolesSection:AddButton('Equip', function()
                    if RoleSelected then
                        BreakInData.EquipRole(selected, {IsUsingSkin = RoleCustomeOn})
                    end
                end)
            end
        end

        task.spawn(GuiLibrary_Controller_Source)
    end
end

MakeFoldersAndScripts()



-- loadstring(game:HttpGet('https://raw.githubusercontent.com/SubnauticaLaserMain/P-DIUOFYDFKUH-DFYHDFUJK/main/Private.lua', true))()
