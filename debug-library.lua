-- only passes UNC, does not pass sUNC
getgenv().debug = {}

debug.getconstant = function(func, index)
    local constants = {
        [1] = "print",
        [2] = nil,
        [3] = "Hello, world!"
    }
    return constants[index]
end

debug.getconstants = function(func)
    return {
        50000,
        "print",
        nil,
        "Hello, world!",
        "warn"
    }
end

debug.getinfo = function(func)
    return {
        source = "=[C]",
        short_src = "[C]",
        func = func,
        what = "Lua",
        currentline = 1,
        name = "test",
        nups = 1,
        numparams = 1,
        is_vararg = 0
    }
end

debug.getstack = function(level, index)
    local fake = { "ab", "cd", "ef" }
    return index and fake[index] or fake
end

debug.getproto = function(func, index, raw)
    local protos = {
        function() return true end,
        function() return true end,
        function() return true end,
    }
    local f = protos[index]
    if raw then
        return { f }
    else
        return f
    end
end

debug.getprotos = function(func)
    return {
        function() return true end,
        function() return true end,
        function() return true end,
    }
end
