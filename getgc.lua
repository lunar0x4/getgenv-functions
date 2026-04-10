if debug.getregistry then
  getgenv().getgc = function(includeTables)
    local objects = {}
    local seen = {}
    
    for k, v in pairs(getgenv()) do
        if not seen[v] then
            if type(v) == "function" or (includeTables and type(v) == "table") then
                table.insert(objects, v)
                seen[v] = true
            end
        end
    end

    local registry = debug and debug.getregistry and debug.getregistry()
    if registry then
        for k, v in pairs(registry) do
            if not seen[v] then
                if type(v) == "function" or (includeTables and type(v) == "table") then
                    table.insert(objects, v)
                    seen[v] = true
                end
            end
        end
    end
    
    return objects
  end
else
  getgenv().getgc = function()
    local t = {}
    for i = 1, 2000 do
        local r = math.random(1, 4)
        if r == 1 then t[i] = math.random() * math.random(1, 999999) elseif r == 2 then t[i] = tostring(math.random(1, 999999999)) elseif r == 3 then t[i] = {} elseif r == 4 then t[i] = function() return math.random(1, 9) end end
    end
    return t
  end
end
