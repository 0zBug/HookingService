
local HookingService = {}

function HookingService:Hook(a, b)
    hookfunction(a, b)
end

function HookingService:DisableConnection(Signal)
    for _, v in next, getconnections(Signal) do
        v:Disable()
    end
end

function HookingService:IndexSpoof(Object, Property, Value)
    local index
    index = hookmetamethod(Object, "__index", function(self, key, ...)
        if key == Property then
            return Value
        end

        return index(self, key, ...)
    end)
end

function HookingService:NameCallSpoof(Object, Method)
    local namecall
    namecall = hookmetamethod(game, "__namecall", function(self, ...)
        if not checkcaller() and self == Object and getnamecallmethod() == Method then
            return
        end
    
        return namecall(self, ...)
    end)
end

function HookingService:HookRemote(Remote, Function)
    local namecall
    namecall = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}

        if not checkcaller() and self == Remote then
            if getnamecallmethod() == "FireServer" or getnamecallmethod() == "InvokeServer" then
                return Function(namecall, self, ...)
            end
        end

        return namecall(self, ...)
    end)
end

function HookingService:ProtectGui(Object)
    Object.Parent = game.CoreGui

    local namecall
    namecall = hookmetamethod(game, "__namecall", function(self, key, ...)
        if not checkcaller() and self == game.CoreGui and getnamecallmethod() == "FindFirstChild" and key == Object.Name then
            return
        end

        return namecall(self, key, ...)
    end)

    local index
    index = hookmetamethod(game, "__index", function(self, key, ...)
        if not checkcaller() and self == game.CoreGui and key == Object.Name then
            return
        end

        return index(self, key, ...)
    end)
end

return HookingService
