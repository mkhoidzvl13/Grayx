-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Raid Tool", "DarkTheme") -- Mặc định là DarkTheme

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
        local contents = readfile("settings.json")
        Settings = HttpService:JSONDecode(contents)
    end
end

-- Gọi hàm tải cài đặt khi khởi động
LoadSettings()

-- Tab Farming
local LeftGroupBox = Window:NewTab("Farming"):NewSection("Auto Farming")

LeftGroupBox:NewToggle("Auto Mobs", "Farms Mobs", function(A)
    Settings.AutoMobs = A
end).Set(Settings.AutoMobs)

LeftGroupBox:NewToggle("Auto Boss Quests", "Farms Boss Quests", function(A)
    Settings.AutoBossQuests = A
end).Set(Settings.AutoBossQuests)

LeftGroupBox:NewToggle("Semi Kill Aura", "Mob Has to be Damaged", function(A)
    Settings.SemiKillAura = A
end).Set(Settings.SemiKillAura)

LeftGroupBox:NewToggle("Auto Dungeon", "Farms Dungeon", function(A)
    Settings.AutoDungeon = A
end).Set(Settings.AutoDungeon)

-- Tab Settings
local SettingsTab = Window:NewTab("Settings"):NewSection("Customization & Save")

-- Nút Lưu Cài Đặt
SettingsTab:NewButton("Lưu Cài Đặt", "Lưu tất cả các cài đặt vào settings.json", function()
    SaveSettings()
    print("Cài đặt đã được lưu.")
end)

-- Đổi màu theme
SettingsTab:NewDropdown("Đổi Theme", "Chọn một theme mới", {"DarkTheme", "LightTheme", "BloodTheme", "GrapeTheme", "Ocean", "Midnight"}, function(theme)
    Window:ChangeTheme(theme)
    Settings.Theme = theme
end).Set(Settings.Theme)

-- Khởi tạo UI
Library:Init()
