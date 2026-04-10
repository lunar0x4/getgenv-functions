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

crypt.generatebytes = function(size)
    local t = {}
    for i = 1, size do
        t[i] = string.char(math.random(0, 255))
    end
    local raw = table.concat(t)
    return crypt.base64encode(raw)
end

crypt.generatekey = function()
    return crypt.generatebytes(32)
end

crypt.encrypt = function(data, key, iv, mode)
    iv = iv or crypt.generatebytes(16)
    return data, iv
end

crypt.decrypt = function(data, key, iv, mode)
    return data
end

crypt.hash = function(data, algorithm)
    return crypt.base64encode("hash:" .. algorithm .. ":" .. data)
end
