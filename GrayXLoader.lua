-- Load Vape UI Library
local Vape = loadstring(game:HttpGet("https://raw.githubusercontent.com/danielga3/Vape-UI/main/Vape%20UI.lua"))()

-- Khởi tạo UI chính
local Window = Vape.CreateWindow("Grayx", "GRAYX")

-- Tạo Tab "Farming" cho các toggle tính năng
local FarmingTab = Window:AddTab("Farming")
local FarmingSection = FarmingTab:AddSection("Auto Farming")

-- Tạo Tab "Settings" cho cài đặt khác
local SettingsTab = Window:AddTab("Settings")
local SettingsSection = SettingsTab:AddSection("Customization & Save")

-- Lưu trữ trạng thái các cài đặt
local Settings = {
    AutoMobs = false,
    AutoBossQuests = false,
    SemiKillAura = false,
    AutoDungeon = false,
    Theme = "DarkTheme"
}

-- Hàm lưu cài đặt vào file JSON
local function SaveSettings()
    local HttpService = game:GetService("HttpService")
    writefile("hub.json", HttpService:JSONEncode(Settings))
end

-- Hàm tải cài đặt từ file JSON
local function LoadSettings()
    local HttpService = game:GetService("HttpService")
    if isfile("hub.json") then
        local contents = readfile("hub.json")
        Settings = HttpService:JSONDecode(contents)
    end
end

-- Gọi hàm tải cài đặt khi khởi động
LoadSettings()

-- Các Toggle trong Tab "Farming"
FarmingSection:AddToggle("Auto Mobs", {
    Default = Settings.AutoMobs,
    Text = "Auto Mobs",
    Callback = function(state)
        Settings.AutoMobs = state
        SaveSettings()

        -- Tạo Auto Mobs chức năng
        spawn(function()
            while Settings.AutoMobs do
                pcall(function()
                    -- Kiểm tra nếu AutoMobs đã được bật
                    local Nig = Player.PlayerGui:FindFirstChild("Main"):FindFirstChild("ingame"):FindFirstChild("Missionstory")

                    -- Kiểm tra điều kiện nếu Missionstory không hiển thị
                    if not Nig.Visible then
                        -- Duyệt qua các mission givers
                        for i, v in next, Workspace.missiongivers:GetChildren() do
                            if v:FindFirstChild("Head") and v.Head:FindFirstChild("givemission") and v.Head.givemission.Enabled and v.Head.givemission:FindFirstChild("color").Image == "http://www.roblox.com/asset/?id=5459241648" then
                                -- Di chuyển đến mission giver và nhận nhiệm vụ
                                Teleport(CFrame.new(v.HumanoidRootPart.Position) * CFrame.new(0, -7, 3))
                                v:FindFirstChild("CLIENTTALK"):FireServer()
                                v:FindFirstChild("CLIENTTALK"):FireServer("accept")
                                break
                            end
                        end
                    end

                    -- Nếu Missionstory hiển thị
                    if Nig.Visible then
                        -- Duyệt qua NPCs và thực hiện hành động
                        for i, v in next, npc:GetChildren() do
                            if v:IsA("Model") and v:FindFirstChild("npctype") and string.find(Nig.bg.name.Text, v.Head.mob.fram.name.info.Text) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Head.CFrame.Y > -1000 then
                                -- Di chuyển tới NPC và tấn công
                                Teleport(CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0, 0, 3)))
                                Player.Character.combat.update:FireServer("mouse1", true)
                                Player.Character.combat.update:FireServer("mouse1", false)

                                -- Loại bỏ exploit và hạ gục NPC
                                local Anti = v:FindFirstChild("antiexploit", true)
                                if Anti then 
                                    Anti:Destroy()
                                end
                                local Humanoid = v:FindFirstChildWhichIsA("Humanoid")
                                if Humanoid.Health then
                                    Humanoid.Health = -9e9
                                end
                                local fakehealth = v:FindFirstChild("fakehealth", true)
                                if fakehealth then
                                    fakehealth.Value = -9e9
                                end
                                wait(0.5)
                            end
                        end
                    end
                end)
                wait(0.1)
            end
        end)
    end
})

FarmingSection:AddToggle("Auto Boss Quests", {
    Default = Settings.AutoBossQuests,
    Text = "Auto Boss Quests",
    Callback = function(state)
        Settings.AutoBossQuests = state
        SaveSettings()

        -- Tạo Auto Boss Quests chức năng
        spawn(function()
            while Settings.AutoBossQuests do
                pcall(function()
                    -- Kiểm tra nếu AutoBossQuests đã được bật
                    local Nig = Player.PlayerGui:FindFirstChild("Main"):FindFirstChild("ingame"):FindFirstChild("Missionstory")

                    -- Kiểm tra điều kiện nếu Missionstory không hiển thị
                    if not Nig.Visible then
                        -- Duyệt qua các boss quests
                        for i, v in next, Workspace.bossdropmission.missions:GetChildren() do
                            for _, mission in next, v:GetChildren() do
                                if mission:IsA("Model") and mission:FindFirstChild("loggys") and not Nig.Visible then
                                    -- Di chuyển đến Boss Quest và nhận nhiệm vụ
                                    Teleport(CFrame.new(mission.HumanoidRootPart.Position + Vector3.new(0, -7, 0)))
                                    mission:FindFirstChild("CLIENTTALK"):FireServer()
                                    mission:FindFirstChild("CLIENTTALK"):FireServer("accept")
                                    wait(0.5)
                                end
                            end
                        end
                    end

                    -- Nếu Missionstory hiển thị
                    if Nig.Visible then
                        -- Duyệt qua NPCs và thực hiện hành động
                        for i, v in next, Workspace.npc:GetChildren() do
                            if v:IsA("Model") and v:FindFirstChild("npctype") and not v.Head.mob.fram.name.info.Text:find("Spirit") and not v:FindFirstChild("rpaw") and string.find(Nig.bg.name.Text, v.Head.mob.fram.name.info.Text) and v.Head.CFrame.Y > -1000 then
                                -- Di chuyển tới Boss NPC và tấn công
                                Teleport(CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0, 0, -3)))
                                Player.Character.combat.update:FireServer("mouse1", true)
                                Player.Character.combat.update:FireServer("mouse1", false)

                                -- Loại bỏ exploit và hạ gục NPC
                                local Anti = v:FindFirstChild("antiexploit", true)
                                if Anti then 
                                    Anti:Destroy()
                                end
                                local Humanoid = v:FindFirstChildWhichIsA("Humanoid")
                                if Humanoid.Health then
                                    Humanoid.Health = -9e9
                                end
                                local fakehealth = v:FindFirstChild("fakehealth", true)
                                if fakehealth then
                                    fakehealth.Value = -9e9
                                end
                                wait(0.5)
                            end
                        end
                    end
                end)
                wait(0.5)
            end
        end)
    end
})

FarmingSection:AddToggle("Semi Kill Aura", {
    Default = Settings.SemiKillAura,
    Text = "Semi Kill Aura",
    Callback = function(state)
        Settings.SemiKillAura = state
        SaveSettings()

        -- Tạo Semi Kill Aura chức năng
        spawn(function()
            while Settings.SemiKillAura do wait()
                pcall(function()
                    -- Duyệt qua các NPCs và thực hiện hành động
                    for i, v in next, npc:GetChildren() do
                        if v:IsA("Model") and v:FindFirstChildWhichIsA("Humanoid") then
                            -- Loại bỏ AntiExploit nếu có
                            local Anti = v:FindFirstChild("antiexploit", true)
                            if Anti then 
                                Anti:Destroy()
                            end

                            -- Hạ gục NPC bằng cách đặt sức khỏe của nó bằng 0
                            local Humanoid = v:FindFirstChildWhichIsA("Humanoid")
                            if Humanoid.Health then
                                Humanoid.Health = 0
                            end

                            -- Hạ fakehealth nếu có
                            local fakehealth = v:FindFirstChild("fakehealth", true)
                            if fakehealth then
                                fakehealth.Value = 0
                            end
                        end
                    end
                end)
            end
        end)
    end
})

FarmingSection:AddToggle("Auto Dungeon", {
    Default = Settings.AutoDungeon,
    Text = "Auto Dungeon",
    Callback = function(state)
        Settings.AutoDungeon = state
        SaveSettings()

        -- Tạo Auto Dungeon chức năng
        spawn(function()
            while Settings.AutoDungeon do wait()
                pcall(function()
                    -- Duyệt qua các NPCs và thực hiện hành động trong Dungeon
                    for i, v in next, npc:GetChildren() do
                        if v:IsA("Model") and v:FindFirstChild("npctype") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Head.CFrame.Y > -1000 then
                            -- Di chuyển đến NPC và tấn công
                            Teleport(CFrame.new(v.HumanoidRootPart.Position) * CFrame.new(0, -7, 3))
                            Player.Character.combat.update:FireServer("mouse1", true)
                        end
                    end
                end)
                wait(0.5) -- Đợi một chút trước khi lặp lại
            end
        end)
    end
})

-- Nút lưu cài đặt trong Tab Settings
SettingsSection:AddButton("Lưu Cài Đặt", function()
    SaveSettings()
    Vape:Notify("Cài đặt đã được lưu.", "success")
end)

-- Dropdown đổi theme trong Tab Settings
SettingsSection:AddDropdown("Đổi Theme", {
    Items = {"DarkTheme", "LightTheme", "BloodTheme", "GrapeTheme", "Ocean", "Midnight"},
    Default = Settings.Theme,
    Callback = function(theme)
        Vape:SetTheme(theme)
        Settings.Theme = theme
        SaveSettings()
    end
})

-- Khởi tạo UI
Vape:Notify("Grayx đã sẵn sàng!", "info")
