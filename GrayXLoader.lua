-- Load Fluent UI Library
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Khởi tạo UI chính
local Window = Fluent:CreateWindow({
    Title = "Grayx",
    SubTitle = "GRAYX",
    TabWidth = 150
})

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
    end
})

FarmingSection:AddToggle("Auto Boss Quests", {
    Default = Settings.AutoBossQuests,
    Text = "Auto Boss Quests",
    Callback = function(state)
        Settings.AutoBossQuests = state
        SaveSettings()
    end
})

FarmingSection:AddToggle("Semi Kill Aura", {
    Default = Settings.SemiKillAura,
    Text = "Semi Kill Aura",
    Callback = function(state)
        Settings.SemiKillAura = state
        SaveSettings()
    end
})

FarmingSection:AddToggle("Auto Dungeon", {
    Default = Settings.AutoDungeon,
    Text = "Auto Dungeon",
    Callback = function(state)
        Settings.AutoDungeon = state
        SaveSettings()
    end
})

-- Nút lưu cài đặt trong Tab Settings
SettingsSection:AddButton("Lưu Cài Đặt", function()
    SaveSettings()
    Fluent:Notify("Cài đặt đã được lưu.", "success")
end)

-- Dropdown đổi theme trong Tab Settings
SettingsSection:AddDropdown("Đổi Theme", {
    Items = {"DarkTheme", "LightTheme", "BloodTheme", "GrapeTheme", "Ocean", "Midnight"},
    Default = Settings.Theme,
    Callback = function(theme)
        Fluent:SetTheme(theme)
        Settings.Theme = theme
        SaveSettings()
    end
})

-- Interface Manager để quản lý trạng thái UI (ẩn/hiện giao diện)
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
InterfaceManager:Load(Window)

-- SaveManager để lưu và tải các cấu hình UI
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
SaveManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"Settings"})
SaveManager:BuildConfigSection(SettingsTab)
SaveManager:LoadSettings()

-- Khởi tạo UI
Fluent:Notify("Raid Tool đã sẵn sàng!", "info")
