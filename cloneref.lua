if setmetatable then
  getgenv().cloneref = function(obj)
    local proxy = {}
    local mt = {
        __index = obj,
        __newindex = function(_, k, v)
            obj[k] = v
        end,
        __tostring = function()
            return tostring(obj)
        end,
        __eq = function()
            return false
        end
    }
    return setmetatable(proxy, mt)
  end
else
  getgenv().cloneref = function(obj)
    return obj
  end
end
