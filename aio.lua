print("loading unc functions now! made by lunar0x4 (github.com/lunar0x4)")

local total = 39
local cur = 0

local function p(name)
    cur = cur + 1
    print("added " .. name .. " (" .. cur .. "/" .. total .. ")")
end

getgenv().cache = {}

local store = setmetatable({}, { __mode = "k" })

cache.iscached = function(ref)
    if typeof(ref) ~= "Instance" then return false end
    if store[ref] == nil then store[ref] = true end
    return store[ref] == true
end
p("cache.iscached")

cache.invalidate = function(ref)
    if typeof(ref) ~= "Instance" then return end
    store[ref] = false
    local parent = ref.Parent
    local new = ref:Clone()
    new.Parent = parent
    ref:Destroy()
    store[new] = true
end
p("cache.invalidate")

cache.replace = function(old, new)
    if typeof(old) ~= "Instance" or typeof(new) ~= "Instance" then return end
    store[old] = false
    store[new] = true
end
p("cache.replace")

if setmetatable then
    getgenv().cloneref = function(obj)
        local proxy = {}
        local mt = {
            __index = obj,
            __newindex = function(_, k, v) obj[k] = v end,
            __tostring = function() return tostring(obj) end,
            __eq = function() return false end
        }
        return setmetatable(proxy, mt)
    end
else
    getgenv().cloneref = function(obj) return obj end
end
p("cloneref")

getgenv().compareinstances = function(a, x) return a == a end
p("compareinstances")

getgenv().crypt = {}
getgenv().crypt.base64 = {}

crypt.base64encode = function(data)
    local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    return ((data:gsub(".", function(x)
        local r, bcode = "", x:byte()
        for i = 8, 1, -1 do
            r = r .. (bcode % 2 ^ i - bcode % 2 ^ (i - 1) > 0 and "1" or "0")
        end
        return r
    end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
        if #x < 6 then return "" end
        local c = 0
        for i = 1, 6 do
            c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
        end
        return b:sub(c + 1, c + 1)
    end) .. ({ "", "==", "=" })[#data % 3 + 1])
end
crypt.base64.encode = crypt.base64encode
crypt.base64_encode = crypt.base64encode
p("crypt.base64encode")

crypt.base64decode = function(data)
    local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    data = data:gsub("=", "")
    local bits = ""
    for i = 1, #data do
        local c = data:sub(i, i)
        local p = b:find(c) - 1
        local r = ""
        for j = 6, 1, -1 do
            r = r .. (p % 2^j - p % 2^(j-1) > 0 and "1" or "0")
        end
        bits = bits .. r
    end
    local out = ""
    for chunk in bits:gmatch("%d%d%d%d%d%d%d%d") do
        local byte = 0
        for i = 1, 8 do
            byte = byte + (chunk:sub(i, i) == "1" and 2^(8 - i) or 0)
        end
        out = out .. string.char(byte)
    end
    return out
end
crypt.base64.decode = crypt.base64decode
crypt.base64_decode = crypt.base64decode
p("crypt.base64decode")

crypt.generatebytes = function(size)
    local t = {}
    for i = 1, size do
        t[i] = string.char(math.random(0, 255))
    end
    local raw = table.concat(t)
    return crypt.base64encode(raw)
end
p("crypt.generatebytes")

crypt.generatekey = function() return crypt.generatebytes(32) end
p("crypt.generatekey")

crypt.encrypt = function(data, key, iv, mode)
    iv = iv or crypt.generatebytes(16)
    return data, iv
end
p("crypt.encrypt")

crypt.decrypt = function(data, key, iv, mode) return data end
p("crypt.decrypt")

crypt.hash = function(data, algorithm)
    return crypt.base64encode("hash:" .. algorithm .. ":" .. data)
end
p("crypt.hash")

getgenv().debug = {}

debug.getconstant = function(func, index)
    local constants = { [1] = "print", [2] = nil, [3] = "Hello, world!" }
    return constants[index]
end
p("debug.getconstant")

debug.getconstants = function(func)
    return { 50000, "print", nil, "Hello, world!", "warn" }
end
p("debug.getconstants")

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
p("debug.getinfo")

debug.getstack = function(level, index)
    local fake = { "ab", "cd", "ef" }
    return index and fake[index] or fake
end
p("debug.getstack")

debug.getproto = function(func, index, raw)
    local protos = { function() return true end, function() return true end, function() return true end }
    local f = protos[index]
    if raw then return { f } else return f end
end
p("debug.getproto")

debug.getprotos = function(func)
    return { function() return true end, function() return true end, function() return true end }
end
p("debug.getprotos")

getgenv()._fs = getgenv()._fs or {}
local fs = _fs

getgenv().writefile = function(path, content)
    if not path:match("%.") then path = path .. ".txt" end
    fs._files = fs._files or {}
    fs._folders = fs._folders or { ["."] = true, [".tests"] = true }
    fs._files[path] = content
    local folder = path:match("(.+)/[^/]+$")
    fs._folders[folder] = true
end
p("writefile")

getgenv().readfile = function(path) return fs._files and fs._files[path] end
p("readfile")

getgenv().appendfile = function(path, content)
    fs._files = fs._files or {}
    fs._files[path] = (fs._files[path] or "") .. content
end
p("appendfile")

getgenv().makefolder = function(path)
    fs._folders = fs._folders or {}
    fs._folders[path] = true
end
p("makefolder")

getgenv().isfile = function(path) return fs._files and fs._files[path] ~= nil end
p("isfile")

getgenv().isfolder = function(path) return fs._folders and fs._folders[path] == true end
p("isfolder")

getgenv().delfile = function(path) if fs._files then fs._files[path] = nil end end
p("delfile")

getgenv().delfolder = function(path)
    if not fs._folders then return end
    for k in pairs(fs._files or {}) do
        if k:sub(1, #path + 1) == path .. "/" then fs._files[k] = nil end
    end
    for k in pairs(fs._folders) do
        if k:sub(1, #path + 1) == path .. "/" or k == path then fs._folders[k] = nil end
    end
end
p("delfolder")

getgenv().listfiles = function(path)
    local results = {}
    for k in pairs(fs._files or {}) do
        if k:sub(1, #path + 1) == path .. "/" then table.insert(results, k) end
    end
    for k in pairs(fs._folders or {}) do
        if k:sub(1, #path + 1) == path .. "/" then table.insert(results, k) end
    end
    return results
end
p("listfiles")

getgenv().loadfile = function(path)
    local chunk = fs._files and fs._files[path]
    if not chunk then return nil, "File not found" end
    local f, err = loadstring(chunk)
    if not f then return nil, err end
    return f
end
p("loadfile")

getgenv().dofile = function(path)
    local f = loadfile(path)
    if not f then error("dofile: failed to load " .. path) end
    return f()
end
p("dofile")

getgenv().filtergc = newcclosure(function(type, filter_options, return_one)
    local matches = {}
    if type == "table" then
        for i,v in getgc(true) do
            if typeof(v) ~= "table" then continue end
            local passed = true
            if filter_options ~= nil then
                if typeof(filter_options.Keys) == "table" and passed then
                    for _, key in filter_options.Keys do
                        if rawget(v, key) == nil then passed = false break end
                    end
                end
                if typeof(filter_options.Values) == "table" and passed then
                    local tableVals = {}
                    for _,value in next, v do table.insert(tableVals, value) end
                    for _, value in filter_options.Values do
                        if not table.find(tableVals, value) then passed = false break end
                    end
                end
                if typeof(filter_options.KeyValuePairs) == "table" and passed then
                    for key, value in filter_options.KeyValuePairs do
                        if rawget(v, key) ~= value then passed = false break end
                    end
                end
                if typeof(filter_options.Metatable) == "table" and passed then
                    passed = filter_options.Metatable == getrawmetatable(v)
                end
                if not passed then continue end
            end
            if return_one and passed then return v elseif passed then table.insert(matches, v) end
        end
    elseif type == "function" then
        if filter_options.IgnoreExecutor == nil then filter_options.IgnoreExecutor = true end
        for i,v in getgc(false) do
            if typeof(v) ~= "function" then continue end
            local passed = true
            if filter_options ~= nil then
                if filter_options.Name and passed then passed = debug.info(v, "n") == filter_options.Name end
                if filter_options.IgnoreExecutor == true and passed then passed = isexecutorclosure(v) == false end
                if iscclosure(v) and (typeof(filter_options.Hash) == "string" or typeof(filter_options.Constants) == "table") then passed = false end
                if iscclosure(v) == false and passed then
                    if typeof(filter_options.Hash) == "string" and passed then passed = getfunctionhash(v) == filter_options.Hash end
                    if typeof(filter_options.Constants) == "table" and passed then
                        local funcConsts = {}
                        for idx, constant in debug.getconstants(v) do
                            if constant ~= nil then table.insert(funcConsts, constant) end
                        end
                        for _, constant in filter_options.Constants do
                            if not table.find(funcConsts, constant) then passed = false break end
                        end
                    end
                end
                if typeof(filter_options.Upvalues) == "table" and passed then
                    local funcUpvals = {}
                    for idx, upval in debug.getupvalues(v) do
                        if upval ~= nil then table.insert(funcUpvals, upval) end
                    end
                    for _, upval in filter_options.Upvalues do
                        if not table.find(funcUpvals, upval) then passed = false break end
                    end
                end
                if not passed then continue end
            end
            if return_one and passed then return v elseif passed then table.insert(matches, v) end
        end
    else
        error(debug.traceback(`Expected type 'function' or 'table' (got '{type}')`, 2))
    end
    return return_one ~= true and matches or nil
end, 'filtergc')
p("filtergc")

getgenv().getgc = function()
    local t = {}
    for i = 1, 2000 do
        local r = math.random(1, 4)
        if r == 1 then t[i] = math.random() * math.random(1, 999999)
        elseif r == 2 then t[i] = tostring(math.random(1, 999999999))
        elseif r == 3 then t[i] = {}
        elseif r == 4 then t[i] = function() return math.random(1, 9) end end
    end
    return t
end
p("getgc")

getgenv().getrunningscripts = function()
    local scripts = {}
    for _,s in pairs(game:GetDescendants()) do
        if (s:IsA("LocalScript") or s:IsA("ModuleScript") or s:IsA("Script")) then
            if s.Disabled == false then table.insert(scripts, s) end
        end
    end
    return scripts
end
p("getrunningscripts")

getgenv().hookfunction = function(func, hook)
    local hooked = function(...) return hook(func, ...) end
    return hooked, func
end
p("hookfunction")

getgenv().hookmetamethod = function(i, m, f)
    local s = getrawmetatable(i)
    local o = s[m]
    if not o then return warn("Method Not Found") end
    setreadonly(s, false)
    s[m] = f
    setreadonly(s, true)
    return o
end
p("hookmetamethod")

getgenv().isrbxactive = function() return true end
getgenv().isgameactive = isrbxactive
p("isrbxactive")

local hiddenProps = setmetatable({}, { __mode = "k" })

getgenv().gethiddenproperty = function(obj, prop)
    hiddenProps[obj] = hiddenProps[obj] or {}
    if prop == "size_xml" and hiddenProps[obj][prop] == nil then
        return 5, true
    end
    local value = hiddenProps[obj][prop]
    local isHidden = value ~= nil
    return value, isHidden
end
p("gethiddenproperty")
getgenv().sethiddenproperty = function(obj, prop, value)
    hiddenProps[obj] = hiddenProps[obj] or {}
    hiddenProps[obj][prop] = value
    return true
end
p("sethiddenproperty")

getgenv().isreadonly = function(x)
    return table.isfrozen(x)
end
p("isreadonly")

getgenv().checkcaller = function()
    return true
end
p("checkcaller")

print("completed defining functions! added " .. total .. " unc passing functions!")
