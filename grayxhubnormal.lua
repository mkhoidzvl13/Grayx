        local Library =
            loadstring(game:HttpGet("https://raw.githubusercontent.com/mkhoidzvl13/Grayx/main/sword.lua"))()
        local Window = Library.CreateLib("NEW VIDEO OUT FOR UPDATED SWORDBURST 3 GUI", "Ocean")

        -- MAIN
        local Main = Window:NewTab("Main")
        local MainSection = Main:NewSection("Main")

MainSection:NewButton("DISCORD", "PASTE LINK TO GOOGLE", function()
local CoreGui = game:GetService("StarterGui") -- Variable of StarterGui
	CoreGui:SetCore("SendNotification", {
		-- Customizable
		Title = "Paste To Google",
		Text = "Copied To Clipboard",
		Duration = 7, -- Set the duration to how much you want this to stay
		-- More code in part 2
	})
    setclipboard("https://discord.gg/E7P7Fz6R")
	toclipboard("https://discord.gg/E7P7Fz6R")
            end)
