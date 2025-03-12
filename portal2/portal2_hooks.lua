include("choreo/glados.lua")

hook.Add("AcceptInput", "Portal 2 Map Fix - RunScriptCode", function(ent, name, activator, caller, data)
    if name == "RunScriptCode" then
        print(ent:GetName().." Ran "..data)
        print("Running script:", data)  -- Debug output
        RunString(data, ent:GetName()..":"..data)
    end
end)