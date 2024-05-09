local MarketPlaceService = game:GetService('MarketplaceService')
local UserInputService = game:GetService('UserInputService')
local InsertService = game:GetService('InsertService')
local CorePackages = game:GetService('CorePackages')






local function new(type, Parent)
    if Parent then
        return Instance.new(type, Parent)
    else
        return Instance.new(type)
    end
end



local function MakeFolders()
    if not CorePackages:FindFirstChild('ServerScriptAPI-Source-MainFolder') then
        local MainFolder = new('Folder', CorePackages)
        local PlayerHttpProvidor = new('Folder', MainFolder)
        local PlayerHttpProvidor_Modules = new('Folder', PlayerHttpProvidor)




        MainFolder.Name = 'ServerScriptAPI-Source-MainFolder'

        PlayerHttpProvidor.Name = 'Player-Http-Providor'

        PlayerHttpProvidor_Modules.Name = 'Modules'
    end

    
end


if not CorePackages:FindFirstChild('ServerScriptAPI-Source-MainFolder') then
    MakeFolders()
end

local function MakeModuleScripts()
    if not CorePackages:FindFirstChild('ServerScriptAPI-Source-MainFolder') then

    end
end


if not CorePackages:FindFirstChild('ServerScriptAPI-Source-MainFolder'):FindFirstChild('Player-Http-Providor'):FindFirstChild('Modules'):FindFirstChild('Player/ScreenShot-Providor') then
    local Player_ScreenShot_Providor_Module = new('ModuleScript', CorePackages:FindFirstChild('ServerScriptAPI-Source-MainFolder'):FindFirstChild('Player-Http-Providor'):FindFirstChild('Modules'))
    Player_ScreenShot_Providor_Module.Name = 'Player/ScreenShot-Providor'
    
    --- Source
    Player_ScreenShot_Providor_Module.Source = [[
local module = {}

module.Name = 'OK'

return module
    ]]
else
    CorePackages:FindFirstChild('ServerScriptAPI-Source-MainFolder'):FindFirstChild('Player-Http-Providor'):FindFirstChild('Modules'):FindFirstChild('Player/ScreenShot-Providor'):Destroy()



    local Player_ScreenShot_Providor_Module = new('ModuleScript', CorePackages:FindFirstChild('ServerScriptAPI-Source-MainFolder'):FindFirstChild('Player-Http-Providor'):FindFirstChild('Modules'))

    Player_ScreenShot_Providor_Module.Name = 'Player/ScreenShot-Providor'

    Player_ScreenShot_Providor_Module.Source = [[
local module = {}

module.Name = 'OK'

return module
    ]]
end
