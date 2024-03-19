function GetBeli()
    local beli = game.Players.LocalPlayer.Data.Beli.Value
    if beli >= 1e6 then
        return tostring(beli/1e6) .. "M"
    elseif beli >= 1e3 then
        return tostring(beli/1e3) .. "K"
    else
        return tostring(beli)
    end
end
function GetFragments()
    local Fragments = game.Players.LocalPlayer.Data.Fragments.Value
    if Fragments >= 1e6 then
        return tostring(Fragments/1e6) .. "M"
    elseif Fragments >= 1e3 then
        return tostring(Fragments/1e3) .. "K"
    else
        return tostring(Fragments)
    end
end
function GetSword()
    local SwordList = {}
    for k, v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory")) do
        if v["Type"] == "Sword" then
            table.insert(SwordList,v.Name.." : "..v["Mastery"])
        end
    end
    local SwordListC = table.concat(SwordList,",")
    return SwordListC
end
function GetGun()
    local GunList = {}
    for k, v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory")) do
        if v["Type"] == "Gun" then
            table.insert(GunList,v.Name.." : "..v["Mastery"])
        end
    end
    local GunListC = table.concat(GunList,",")
    return GunListC
end
function CheckMaterialCount()
    local MaterialsInventoryList = {}
    for k, v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory")) do
        if v["Type"] == "Material" then
            table.insert(MaterialsInventoryList,v.Name.." : "..v["Count"])
        end
    end
    local MaterialC = table.concat(MaterialsInventoryList,"\n")
    return MaterialC
end
local CTXWebhookfunc = {
    ["content"] = "\67\84\88\32\65\112\105\32\76\111\97\100\105\110\103\115",
    ["embeds"] = {
        {
            ["color"] = 15466240,
            ["fields"] = {
                {
                    ["name"] = "\80\108\97\121\101\114\115\32\45\32\73\68\32\80\108\97\121\101\114\115",
                    ["value"] = "```yml\n"..game.Players.LocalPlayer.Name.." - "..game.Players.LocalPlayer.UserId.."\n```",
                    ["inline"] = true
                },
                {
                    ["name"] = "\76\101\118\101\108\32\45\32\66\101\108\105\32\45\32\70\114\97\103",
                    ["value"] = "```yml\n"..game.Players.LocalPlayer.Data.Level.Value.." - "..GetBeli().." - "..GetFragments().."\n```",
                    ["inline"] = true
                },
                {
                    ["name"] = "\83\119\111\114\100",
                    ["value"] = "```yml\n"..GetSword().."\n```"
                },
                {
                    ["name"] = "\71\117\110",
                    ["value"] = "```yml\n"..GetGun().."\n```"
                },
                {
                    ["name"] = "\77\97\116\101\114\105\97\108",
                    ["value"] = "```yml\n"..CheckMaterialCount().."\n```"
                }
            },
            ["author"] = {
                ["name"] = "Blox Fruits"
            },
            ["footer"] = {
                ["text"] = "Grayx hub",
                ["icon_url"] = "https://cdn.discordapp.com/attachments/1218431024187445248/1219496916614905968/f5ec64b40d2adf7deb84e3c0e192ff32.gif?ex=660b8402&is=65f90f02&hm=a4dac3d27875cdf085add8a827cb818b8b10f6c52ab2a18a641838d78c1eb91d&"
            },
            ["timestamp"] = "2024-03-19T11:38:00.000Z",
            ["image"] = {
                ["url"] = "https://cdn.discordapp.com/attachments/1218431024187445248/1219496916614905968/f5ec64b40d2adf7deb84e3c0e192ff32.gif?ex=660b8402&is=65f90f02&hm=a4dac3d27875cdf085add8a827cb818b8b10f6c52ab2a18a641838d78c1eb91d&"
            },
            ["thumbnail"] = {
                ["url"] = "https://cdn.discordapp.com/attachments/1218431024187445248/1219496916614905968/f5ec64b40d2adf7deb84e3c0e192ff32.gif?ex=660b8402&is=65f90f02&hm=a4dac3d27875cdf085add8a827cb818b8b10f6c52ab2a18a641838d78c1eb91d&"
            }
        }
    },
    ["username"] = "\67\84\88\32\87\101\98\104\111\111\107\32\65\112\105",
    ["attachments"] = {}
}
local Send = http_request or request or HttpPost or syn.request
Send({Url = UrlWebhook, Body = game:GetService("HttpService"):JSONEncode(CTXWebhookfunc), Method = "POST", Headers = {["content-type"] = "application/json"}})
