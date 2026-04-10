getgenv().hookfunction = function(func, hook)
    local hooked = function(...)
        return hook(func, ...)
    end
    return hooked, func
end
