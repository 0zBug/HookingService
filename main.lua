
local HookingService = {}

function GenHook()
    return nil
end

function HookingService:Hook(a, b)
    hookfunction(a, b)
end

function HookingService:DisableConnection(Signal)
    for i,v in next, getconnections(Signal) do
        v:Disable()
    end
end

function HookingService:IndexSpoof(Path, Attribute, Value)
    local Hook = GenHook()

    Hook = hookmetamethod(game, "__index", function(...)
        local Self, Key = ...

        if not checkcaller() and Self == Path and Key == Attribute then
            return Value
        end

        return Hook(...)
    end)
end

function HookingService:NameCallSpoof(Path, Method)
    local Hook = GenHook()

    Hook = hookmetamethod(game, "__namecall", function(...)
        local Args = {...}
        local Self = Args[1]
        local NamecallMethod = getnamecallmethod()

        if not checkcaller() and Self == Path and NamecallMethod == Method then
            return
        end
    
        return Hook(...)
    end)
end

function HookingService:ProtectGui(Object)
    local Hook = GenHook()
    local Hook2 = GenHook()
    Object.Parent = game.CoreGui

    Hook = hookmetamethod(game, "__namecall", function(...)
        local Args = {...}
        local Self = Args[1]
        local NamecallMethod = getnamecallmethod()

        if not checkcaller() and Self == game.CoreGui and NamecallMethod == "FindFirstChild" and Args[2] == Object.Name then
            return
        end

        return Hook(...)
    end)

    Hook2 = hookmetamethod(game, "__index", function(...)
        local Self, Key = ...

        if not checkcaller() and Self == game.CoreGui and Key == Object.Name then
            return
        end

        return Hook2(...)
    end)
end

function HookingService:HookRemote(Remote, Function)
    local met = getrawmetatable(game)
    setreadonly(met,false)
    local old = met.__namecall

    met.__namecall = function(t,...) 
        local args = {...}
        local method = getnamecallmethod()
        
        if method == "FireServer" or method == "InvokeServer" then
            if (tostring(t) == Remote.Name) then
                return Function(old, t, ...)
            end
        end
        
        return old(t,...)
    end
end

return HookingService
