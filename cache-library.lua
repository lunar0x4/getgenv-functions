-- the entire cache library
getgenv().cache = {}
local store = setmetatable({}, { __mode = "k" })

cache.iscached = function(ref)
    if typeof(ref) ~= "Instance" then return false end
    if store[ref] == nil then store[ref] = true end
    return store[ref] == true
end

cache.invalidate = function(ref)
    if typeof(ref) ~= "Instance" then return end
    store[ref] = false
    local parent = ref.Parent
    local new = ref:Clone()
    new.Parent = parent
    ref:Destroy()
    store[new] = true
end

cache.replace = function(old, new)
    if typeof(old) ~= "Instance" or typeof(new) ~= "Instance" then return end
    store[old] = false
    store[new] = true
end
