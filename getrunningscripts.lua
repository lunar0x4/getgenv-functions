getgenv().getrunningscripts = function()
    local scripts = {}
    for _,s in pairs(game:GetDescendants()) do
        if (s:IsA("LocalScript") or s:IsA("ModuleScript") or s:IsA("Script")) then
            if s.Disabled == false then
                table.insert(scripts, s)
            end
        end
    end
    return scripts
end
