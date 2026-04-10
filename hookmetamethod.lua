assert(getrawmetatable, "getrawmetatable missing")
local makeWritable = setreadonly or makewriteable or make_writeable
assert(makeWritable, "missing setreadonly/makewriteable")
local useSetreadonly = setreadonly ~= nil

getgenv().hookmetamethod = function(i, m, f)
    local s = getrawmetatable(i)
    local o = s[m]
    if not o then return warn("Method Not Found") end
    if useSetreadonly then
        setreadonly(s, false)
        s[m] = f
        setreadonly(s, true)
    else
        makeWritable(s)
        s[m] = f
    end
    return o
end
