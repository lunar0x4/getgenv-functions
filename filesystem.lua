-- does not save it in your executor
getgenv()._fs = getgenv()._fs or {}
local fs = _fs

getgenv().writefile = function(path, content)
    if not path:match("%.") then path = path .. ".txt" end
    fs._files = fs._files or {}
    fs._folders = fs._folders or {["."] = true, [".tests"] = true}
    fs._files[path] = content
    local folder = path:match("(.+)/[^/]+$")
    fs._folders[folder] = true
end

getgenv().readfile = function(path)
    return fs._files and fs._files[path]
end

getgenv().appendfile = function(path, content)
    fs._files = fs._files or {}
    fs._files[path] = (fs._files[path] or "") .. content
end

getgenv().makefolder = function(path)
    fs._folders = fs._folders or {}
    fs._folders[path] = true
end

getgenv().isfile = function(path)
    return fs._files and fs._files[path] ~= nil
end

getgenv().isfolder = function(path)
    return fs._folders and fs._folders[path] == true
end

getgenv().delfile = function(path)
    if fs._files then fs._files[path] = nil end
end

getgenv().delfolder = function(path)
    if not fs._folders then return end
    for k in pairs(fs._files or {}) do
        if k:sub(1, #path + 1) == path .. "/" then
            fs._files[k] = nil
        end
    end
    for k in pairs(fs._folders) do
        if k:sub(1, #path + 1) == path .. "/" or k == path then
            fs._folders[k] = nil
        end
    end
end

getgenv().listfiles = function(path)
    local results = {}
    for k in pairs(fs._files or {}) do
        if k:sub(1, #path + 1) == path .. "/" then
            table.insert(results, k)
        end
    end
    for k in pairs(fs._folders or {}) do
        if k:sub(1, #path + 1) == path .. "/" then
            table.insert(results, k)
        end
    end
    return results
end

getgenv().loadfile = function(path)
    local chunk = fs._files and fs._files[path]
    if not chunk then return nil, "File not found" end
    local f, err = loadstring(chunk)
    if not f then return nil, err end
    return f
end

getgenv().dofile = function(path)
    local f = loadfile(path)
    if not f then error("dofile: failed to load " .. path) end
    return f()
end
