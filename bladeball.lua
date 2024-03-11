do
    local ui = game:GetService("CoreGui").RobloxGui.Modules.Profile:FindFirstChild("UILibrary")
    if ui then ui:Destroy() end
end

do
    local ui = game:GetService("Lighting"):FindFirstChild("Blur")
    if ui then ui:Destroy() end
end


if not game:IsLoaded() then
    local Loaded = Instance.new("Message", workspace)
    Loaded.Text = 'Wait Game Loading'
    game.Loaded:Wait()
    Loaded:Destroy()
    task.wait(10)
end


repeat wait() until game.Players.LocalPlayer

if not game:IsLoaded() then
	local GameLoadGui = Instance.new("Message",workspace);
	GameLoadGui.Text = 'Wait Game Loading';
	game.Loaded:Wait();
	GameLoadGui:Destroy();
	task.wait(10);
end;
--

do  local ui =  game:GetService("CoreGui").RobloxGui.Modules.Profile:FindFirstChild("UILibrary")  if ui then ui:Destroy() end end  

do  local ui =  game:GetService("Lighting"):FindFirstChild("Blur")  if ui then ui:Destroy() end end

local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local tween = game:service"TweenService"
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local GuiService = game:GetService("GuiService")

local function tablefound(ta, object)
	for i,v in pairs(ta) do
		if v == object then
			return true
		end
	end
	return false
end

local ActualTypes = {
	RoundFrame = "ImageLabel",
	Shadow = "ImageLabel",
	Circle = "ImageLabel",
	CircleButton = "ImageButton",
	Frame = "Frame",
	Label = "TextLabel",
	Button = "TextButton",
	SmoothButton = "ImageButton",
	Box = "TextBox",
	ScrollingFrame = "ScrollingFrame",
	Menu = "ImageButton",
	NavBar = "ImageButton"
}

local Properties = {
	RoundFrame = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	SmoothButton = {
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	Shadow = {
		Name = "Shadow",
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554236805",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(23,23,277,277),
		Size = UDim2.fromScale(1,1) + UDim2.fromOffset(30,30),
		Position = UDim2.fromOffset(-15,-15)
	},
	Circle = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	CircleButton = {
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	Frame = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1,1)
	},
	Label = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Button = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Box = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	ScrollingFrame = {
		BackgroundTransparency = 1,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.fromScale(0,0),
		Size = UDim2.fromScale(1,1)
	},
	Menu = {
		Name = "More",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5555108481",
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromScale(1,0.5) - UDim2.fromOffset(25,10)
	},
	NavBar = {
		Name = "SheetToggle",
		Image = "http://www.roblox.com/asset/?id=5576439039",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromOffset(5,5),
		AutoButtonColor = false
	}
}

local Types = {
	"RoundFrame",
	"Shadow",
	"Circle",
	"CircleButton",
	"Frame",
	"Label",
	"Button",
	"SmoothButton",
	"Box",
	"ScrollingFrame",
	"Menu",
	"NavBar"
}

function FindType(String)
	for _, Type in next, Types do
		if Type:sub(1, #String):lower() == String:lower() then
			return Type
		end
	end
	return false
end

local Objects = {}

function Objects.new(Type)
	local TargetType = FindType(Type)
	if TargetType then
		local NewImage = Instance.new(ActualTypes[TargetType])
		if Properties[TargetType] then
			for Property, Value in next, Properties[TargetType] do
				NewImage[Property] = Value
			end
		end
		return NewImage
	else
		return Instance.new(Type)
	end
end

local function GetXY(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end

local function CircleAnim(GuiObject, EndColour, StartColour)
	local PX, PY = GetXY(GuiObject)
	local Circle = Objects.new("Shadow")
	Circle.Size = UDim2.fromScale(0,0)
	Circle.Position = UDim2.fromScale(PX,PY)
	Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
	Circle.ZIndex = 200
	Circle.Parent = GuiObject
	local Size = GuiObject.AbsoluteSize.X
	TweenService:Create(Circle, TweenInfo.new(0.5), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
	spawn(function()
		wait(0.5)
		Circle:Destroy()
	end)
end

local UILibrary = Instance.new("ScreenGui")
local Load = Instance.new("Frame")
local UICornerLoad = Instance.new("UICorner")
local LoadButton = Instance.new("ImageButton")

UILibrary.Name = "UILibrary"
UILibrary.Parent = game:GetService("CoreGui").RobloxGui.Modules.Profile
UILibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Load.Name = "Load"
Load.Parent = UILibrary
Load.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Load.BackgroundTransparency = 1
Load.BorderSizePixel = 0
Load.Position = UDim2.new(0,100, 0,85)
Load.Size = UDim2.new(0, 0, 0, 0) --(0, 100, 0, 100)
Load.BackgroundTransparency = 1

local uitoggled = false
UserInputService.InputBegan:Connect(
	function(io, p)
		if io.KeyCode == Enum.KeyCode.RightControl then
			if uitoggled == false then
				uitoggled = true
				UILibrary.Enabled = false
			else
				UILibrary.Enabled = true
				uitoggled = false
			end
		end
	end
)

UICornerLoad.CornerRadius = UDim.new(0, 30)
UICornerLoad.Name = "UICornerLoad"
UICornerLoad.Parent = Load

LoadButton.Name = "LoadButton"
LoadButton.Parent = Load
LoadButton.AnchorPoint = Vector2.new(0.5, 0.5)
LoadButton.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadButton.BackgroundTransparency = 1.000
LoadButton.Size = UDim2.new(0, 50, 0, 50)
LoadButton.Image = "http://www.roblox.com/asset/?id=14645512457" --ใส๋โลโก้
LoadButton.ImageTransparency = 1

local ClickFrame = Instance.new("Frame")

ClickFrame.Name = "ClickFrame"
ClickFrame.Parent = Load
ClickFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClickFrame.BackgroundTransparency = 1.000
ClickFrame.Position = UDim2.new(0, 0, 7.62939436e-08, 0)
ClickFrame.Size = UDim2.new(0, 0, 0, 0)

local SoundClick = Instance.new("Sound")

SoundClick.Name = "Sound Effect"
SoundClick.Parent = Load
SoundClick.SoundId = "rbxassetid://8055713313" 
SoundClick.Volume = 1

local SoundClick2 = Instance.new("Sound")

SoundClick2.Name = "Sound Effect"
SoundClick2.Parent = Load
SoundClick2.SoundId = "rbxassetid://3398620867" --
SoundClick2.Volume = 1


local Blur = Instance.new("BlurEffect")

Blur.Size = 0
Blur.Parent = game.Lighting

if game.Workspace.Camera.FieldOfView == 0 then
	return game.Workspace.Camera.FieldOfView == 0
end

local LoadText = Instance.new("Frame")
local UIListLayoutLoadText = Instance.new("UIListLayout")
local TitleLoad = Instance.new("TextLabel")

LoadText.Name = "LoadText"
LoadText.Parent = Load
LoadText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadText.BackgroundTransparency = 1.000
LoadText.Size = UDim2.new(0, 500, 0, 50)
LoadText.ClipsDescendants = true

UIListLayoutLoadText.Name = "UIListLayoutLoadText"
UIListLayoutLoadText.Parent = LoadText
UIListLayoutLoadText.FillDirection = Enum.FillDirection.Horizontal
UIListLayoutLoadText.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayoutLoadText.SortOrder = Enum.SortOrder.LayoutOrder

TitleLoad.Name = "TitleLoad"
TitleLoad.Parent = LoadText
TitleLoad.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleLoad.BackgroundTransparency = 1.000
TitleLoad.Size = UDim2.new(0, 200, 0, 50)
TitleLoad.Font = Enum.Font.Gotham
TitleLoad.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLoad.TextSize = 14.000
TitleLoad.TextTransparency = 1

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
		Tween:Play()
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
				input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

local Scrollbar = Instance.new("Frame")
local LoadScrollbar = Instance.new("ImageButton")

Scrollbar.Name = "Scrollbar"
Scrollbar.Parent = Load
Scrollbar.Active = true
Scrollbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Scrollbar.BackgroundTransparency = 1.000
Scrollbar.ClipsDescendants = true
Scrollbar.Position = UDim2.new(0.899999976, 0, -0.0199999232, 0)
Scrollbar.Size = UDim2.new(0, 50, 0, 51)

LoadScrollbar.Name = "LoadScrollbar"
LoadScrollbar.Parent = Scrollbar
LoadScrollbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadScrollbar.AnchorPoint = Vector2.new(0.5,0.5)
LoadScrollbar.BackgroundTransparency = 1.000
LoadScrollbar.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadScrollbar.Size = UDim2.new(0, 30, 0, 30)
LoadScrollbar.Image = "http://www.roblox.com/asset/?id=6031097225"
LoadScrollbar.ImageTransparency = 1
LoadScrollbar.Visible = false

local osday = Instance.new("TextLabel")

osday.Name = "osday"
osday.Parent = ClickFrame
osday.Active = true
osday.AnchorPoint = Vector2.new(0.5, 0.5)
osday.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
osday.BackgroundTransparency = 1.000
osday.Position = UDim2.new(0.5, 0, 0.699999988, 0)
osday.Size = UDim2.new(0, 384, 0, 30)
osday.Font = Enum.Font.GothamBold
osday.TextTransparency = 1
osday.TextColor3 = Color3.fromRGB(255, 255, 255)
osday.TextSize = 14.000

task.spawn(function()
	while task.wait() do
		pcall(function()
			osday.Text = os.date("%I:%M:%S".." | ".."%B %d, %Y")
		end)
	end
end)

local Title = Instance.new("TextLabel")

Title.Name = "Title"
Title.Parent = ClickFrame
Title.Active = true
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0.5, 0, 0.280000001, 0)
Title.Size = UDim2.new(0, 384, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "BLOX FRUIT PREMIUM EDITION"
Title.TextTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 0, 127)
Title.TextSize = 14.000


function LoadFunction()

	TweenService:Create(
		game.Workspace.Camera,
		TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
		{FieldOfView = 70}
	):Play()

	TweenService:Create(
		Blur,
		TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
		{Size = 0}
	):Play()

	--TweenService:Create(
	--	Load,
	--	TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
	--	{Position = UDim2.new(0.5, 0, 0.5, 0)}
	--):Play()
	TweenService:Create(
		Load,
		TweenInfo.new(.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
		{BackgroundTransparency = 0}
	):Play()
	wait(.5)
	TweenService:Create(
		LoadButton,
		TweenInfo.new(.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
		{ImageTransparency = 0}
	):Play()

	LoadButton.MouseEnter:Connect(function()
		TweenService:Create(
			LoadButton,
			TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
			{Size = UDim2.new(0, 80, 0, 80)}
		):Play()
	end)

	LoadButton.MouseLeave:Connect(function()
		TweenService:Create(
			LoadButton,
			TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
			{Size = UDim2.new(0, 50, 0, 50)}
		):Play()
	end)

	local LoadFocus = false

	LoadButton.MouseButton1Down:Connect(function()
		if LoadFocus == false then 
			LoadFocus = false
			TweenService:Create(
				LoadButton,
				TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
				{Rotation = 180}
			):Play()
			SoundClick2:Play()
			TweenService:Create(
				LoadButton,
				TweenInfo.new(.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
				{ImageTransparency = 0}
			):Play()
			wait(.5)
			TweenService:Create(
				LoadButton,
				TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
				{Rotation = 0}
			):Play()
			--SoundClick:Play()
			TweenService:Create(
				LoadButton,
				TweenInfo.new(.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
				{ImageTransparency = 0}
			):Play()
			wait(.5)	
			
		end
	end)
end
LoadFunction()

-- เมื่อคลิกปุ่มใน ImageButton
LoadButton.MouseButton1Down:connect(function()
	game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.F1,false,game)
    game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.F1,false,game)
end)
--uiเปิดปิด


local PlaceName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)

    if not game:IsLoaded() then repeat game.Loaded:Wait() until game:IsLoaded() end
    
    repeat wait() until game:GetService("Players")
    
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") end
        
    wait(1)

do local GUI = game:GetService("CoreGui").RobloxGui.Modules.Profile:FindFirstChild("VectorHub");if GUI then GUI:Destroy();end;
end

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
		local Tween = TweenService:Create(object, TweenInfo.new(0.15), {Position = pos})
		Tween:Play()
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
				input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

local VectorHub = {}

function VectorHub:ToggleUi()
if game:GetService("CoreGui").RobloxGui.Modules.Profile:FindFirstChild("VectorHub").Enabled == true then -- oh am dumb
	game:GetService("CoreGui").RobloxGui.Modules.Profile:FindFirstChild("VectorHub").Enabled = false
else
	game:GetService("CoreGui").RobloxGui.Modules.Profile:FindFirstChild("VectorHub").Enabled = true
end
end

function VectorHub:Window(text,gamenme,logo,keybind)
    local hubname = text
    local gamename = gamenme
	local uihide = false
	local abc = false
	local logo = logo or 0
	local currentpage = ""
	local keybind = keybind or Enum.KeyCode.RightControl
	local yoo = string.gsub(tostring(keybind),"Enum.KeyCode.","")
	if gamename == "" then 
	    gamename = ""..PlaceName.Name
    end
	
	local VectorHub = Instance.new("ScreenGui") -- guess i am using hubname wrong
	VectorHub.Name = "VectorHub" -- wait 
	VectorHub.Parent = game:GetService("CoreGui").RobloxGui.Modules.Profile
	VectorHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Parent = VectorHub
	Main.ClipsDescendants = true
	Main.AnchorPoint = Vector2.new(0.5,0.5)
	Main.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 0, 0, 0)
	
	Main:TweenSize(UDim2.new(0, 656, 0, 400),"Out","Quad",0.4,true)

	local MCNR = Instance.new("UICorner")
	MCNR.Name = "MCNR"
	MCNR.Parent = Main

	local Top = Instance.new("Frame")
	Top.Name = "Top"
	Top.Parent = Main
	Top.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Top.Size = UDim2.new(0, 656, 0, 27)

	local TCNR = Instance.new("UICorner")
	TCNR.Name = "TCNR"
	TCNR.Parent = Top

	local Logo = Instance.new("ImageLabel")
	Logo.Name = "Logo"
	Logo.Parent = Top
	Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Logo.BackgroundTransparency = 1.000
	Logo.Position = UDim2.new(0, 10, 0, 1)
	Logo.Size = UDim2.new(0, 25, 0, 25)
	Logo.Image = ""

	local Name = Instance.new("TextLabel")
	Name.Name = "Name"
	Name.Parent = Top
	Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Name.BackgroundTransparency = 1.000
	Name.Position = UDim2.new(0.0609756112, 0, 0, 0)
	Name.Size = UDim2.new(0, 61, 0, 27)
	Name.Font = Enum.Font.GothamSemibold
	Name.Text = hubname
	Name.TextColor3 = Color3.fromRGB(0, 108, 219)
	Name.TextSize = 17.000

	local Hub = Instance.new("TextLabel")
	Hub.Name = "Hub"
	Hub.Parent = Top
	Hub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Hub.BackgroundTransparency = 1.000
	Hub.Position = UDim2.new(0, 110, 0, 0)
	Hub.Size = UDim2.new(0, 81, 0, 27)
	Hub.Font = Enum.Font.GothamSemibold
	Hub.Text = "  | "..gamename
	Hub.TextColor3 = Color3.fromRGB(0, 108, 219)
	Hub.TextSize = 17.000
	Hub.TextXAlignment = Enum.TextXAlignment.Left

	local BindButton = Instance.new("TextButton")
	BindButton.Name = "BindButton"
	BindButton.Parent = Top
	BindButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BindButton.BackgroundTransparency = 1.000
	BindButton.Position = UDim2.new(0.847561002, 0, 0, 0)
	BindButton.Size = UDim2.new(0, 100, 0, 27)
	BindButton.Font = Enum.Font.GothamSemibold
	BindButton.Text = "[F1]"
	BindButton.TextColor3 = Color3.fromRGB(0, 108, 219)
	BindButton.TextSize = 13.000

	local Tab = Instance.new("Frame")
	Tab.Name = "Tab"
	Tab.Parent = Main
	Tab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Tab.Position = UDim2.new(0, 5, 0, 30)
	Tab.Size = UDim2.new(0, 150, 0, 365)

	local TCNR = Instance.new("UICorner")
	TCNR.Name = "TCNR"
	TCNR.Parent = Tab

	local ScrollTab = Instance.new("ScrollingFrame")
	ScrollTab.Name = "ScrollTab"
	ScrollTab.Parent = Tab
	ScrollTab.Active = true
	ScrollTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollTab.BackgroundTransparency = 1.000
	ScrollTab.Size = UDim2.new(0, 150, 0, 365)
	ScrollTab.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollTab.ScrollBarThickness = 0

	local PLL = Instance.new("UIListLayout")
	PLL.Name = "PLL"
	PLL.Parent = ScrollTab
	PLL.SortOrder = Enum.SortOrder.LayoutOrder
	PLL.Padding = UDim.new(0, 15)

	local PPD = Instance.new("UIPadding")
	PPD.Name = "PPD"
	PPD.Parent = ScrollTab
	PPD.PaddingLeft = UDim.new(0, 10)
	PPD.PaddingTop = UDim.new(0, 10)

	local Page = Instance.new("Frame")
	Page.Name = "Page"
	Page.Parent = Main
	Page.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Page.Position = UDim2.new(0.245426834, 0, 0.075000003, 0)
	Page.Size = UDim2.new(0, 490, 0, 365)

	local PCNR = Instance.new("UICorner")
	PCNR.Name = "PCNR"
	PCNR.Parent = Page

	local MainPage = Instance.new("Frame")
	MainPage.Name = "MainPage"
	MainPage.Parent = Page
	MainPage.ClipsDescendants = true
	MainPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainPage.BackgroundTransparency = 1.000
	MainPage.Size = UDim2.new(0, 490, 0, 365)

	local PageList = Instance.new("Folder")
	PageList.Name = "PageList"
	PageList.Parent = MainPage

	local UIPageLayout = Instance.new("UIPageLayout")

	UIPageLayout.Parent = PageList
	UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
	UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
	UIPageLayout.FillDirection = Enum.FillDirection.Vertical
	UIPageLayout.Padding = UDim.new(0, 15)
	UIPageLayout.TweenTime = 0.400
	UIPageLayout.GamepadInputEnabled = false
	UIPageLayout.ScrollWheelInputEnabled = false
	UIPageLayout.TouchInputEnabled = false
	
	MakeDraggable(Top,Main)

	UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode[yoo] then
			if uihide == false then
				uihide = true
				Main:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",0.4,true)
			else
				uihide = false
				Main:TweenSize(UDim2.new(0, 656, 0, 400),"Out","Quad",0.4,true)
			end
		end
	end)
	
	local uitab = {}
	
	function uitab:Tab(text)
		local TabButton = Instance.new("TextButton")
		TabButton.Parent = ScrollTab
		TabButton.Name = text.."Server"
		TabButton.Text = text
		TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	    TabButton.BorderColor3 = Color3.fromRGB(0, 108, 219)
        TabButton.BorderSizePixel = 2
		TabButton.Size = UDim2.new(0, 130, 0, 23)
		TabButton.Font = Enum.Font.GothamSemibold
		TabButton.TextColor3 = Color3.fromRGB(225, 225, 225)
		TabButton.TextSize = 15.000
		TabButton.TextTransparency = 0.500

		local MainFramePage = Instance.new("ScrollingFrame")
		MainFramePage.Name = text.."_Page"
		MainFramePage.Parent = PageList
		MainFramePage.Active = true
		MainFramePage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MainFramePage.BackgroundTransparency = 1.000
		MainFramePage.BorderSizePixel = 0
		MainFramePage.Size = UDim2.new(0, 490, 0, 365)
		MainFramePage.CanvasSize = UDim2.new(0, 0, 0, 0)
		MainFramePage.ScrollBarThickness = 0
		
		local UIPadding = Instance.new("UIPadding")
		local UIListLayout = Instance.new("UIListLayout")
		
		UIPadding.Parent = MainFramePage
		UIPadding.PaddingLeft = UDim.new(0, 10)
		UIPadding.PaddingTop = UDim.new(0, 10)

		UIListLayout.Padding = UDim.new(0,15)
		UIListLayout.Parent = MainFramePage
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		
		TabButton.MouseButton1Click:Connect(function()
			for i,v in next, ScrollTab:GetChildren() do
				if v:IsA("TextButton") then
					TweenService:Create(
						v,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 0.5}
					):Play()
				end
				TweenService:Create(
					TabButton,
					TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end
			for i,v in next, PageList:GetChildren() do
				currentpage = string.gsub(TabButton.Name,"Server","").."_Page"
				if v.Name == currentpage then
					UIPageLayout:JumpTo(v)
				end
			end
		end)

		if abc == false then
			for i,v in next, ScrollTab:GetChildren() do
				if v:IsA("TextButton") then
					TweenService:Create(
						v,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 0.5}
					):Play()
				end
				TweenService:Create(
					TabButton,
					TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end
			UIPageLayout:JumpToIndex(1)
			abc = true
		end
		
		game:GetService("RunService").Stepped:Connect(function()
			pcall(function()
				MainFramePage.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 20)
				ScrollTab.CanvasSize = UDim2.new(0,0,0,PLL.AbsoluteContentSize.Y + 20)
			end)
		end)
		
		local main = {}
		function main:Button(text,callback)
			local Button = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local TextBtn = Instance.new("TextButton")
			local UICorner_2 = Instance.new("UICorner")
			local Black = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			
			Button.Name = "Button"
			Button.Parent = MainFramePage
			Button.BackgroundColor3 = Color3.fromRGB(0, 108, 219)
			Button.Size = UDim2.new(0, 470, 0, 31)
			
			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = Button
			
			TextBtn.Name = "TextBtn"
			TextBtn.Parent = Button
			TextBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) 
			TextBtn.Position = UDim2.new(0, 1, 0, 1)
			TextBtn.Size = UDim2.new(0, 468, 0, 29)
			TextBtn.AutoButtonColor = false
			TextBtn.Font = Enum.Font.GothamSemibold
			TextBtn.Text = text
			TextBtn.TextColor3 = Color3.fromRGB(225, 225, 225)
			TextBtn.TextSize = 15.000
			
			UICorner_2.CornerRadius = UDim.new(0, 5)
			UICorner_2.Parent = TextBtn
			
			Black.Name = "Black"
			Black.Parent = Button
			Black.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Black.BackgroundTransparency = 1.000
			Black.BorderSizePixel = 0
			Black.Position = UDim2.new(0, 1, 0, 1)
			Black.Size = UDim2.new(0, 468, 0, 29)
			
			UICorner_3.CornerRadius = UDim.new(0, 5)
			UICorner_3.Parent = Black

			TextBtn.MouseEnter:Connect(function()
				TweenService:Create(
					Black,
					TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
					{BackgroundTransparency = 0.7}
				):Play()
			end)
			TextBtn.MouseLeave:Connect(function()
				TweenService:Create(
					Black,
					TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
					{BackgroundTransparency = 1}
				):Play()
			end)
			TextBtn.MouseButton1Click:Connect(function()
				TextBtn.TextSize = 0
				TweenService:Create(
					TextBtn,
					TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
					{TextSize = 15}
				):Play()
				callback()
			end)
		end
		function main:Toggle(text,config,callback)
			config = config or false
			local toggled = config
			local Toggle = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Button = Instance.new("TextButton")
			local UICorner_2 = Instance.new("UICorner")
			local Label = Instance.new("TextLabel")
			local ToggleImage = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local Circle = Instance.new("Frame")
			local UICorner_4 = Instance.new("UICorner")

			Toggle.Name = "Toggle"
			Toggle.Parent = MainFramePage
			Toggle.BackgroundColor3 = Color3.fromRGB(0, 108, 219)
			Toggle.Size = UDim2.new(0, 470, 0, 31)

			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = Toggle

			Button.Name = "Button"
			Button.Parent = Toggle
			Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			Button.Position = UDim2.new(0, 1, 0, 1)
			Button.Size = UDim2.new(0, 468, 0, 29)
			Button.AutoButtonColor = false
			Button.Font = Enum.Font.SourceSans
			Button.Text = ""
			Button.TextColor3 = Color3.fromRGB(0, 0, 0)
			Button.TextSize = 11.000

			UICorner_2.CornerRadius = UDim.new(0, 5)
			UICorner_2.Parent = Button

			Label.Name = "Label"
			Label.Parent = Toggle
			Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Label.BackgroundTransparency = 1.000
			Label.Position = UDim2.new(0, 1, 0, 1)
			Label.Size = UDim2.new(0, 468, 0, 29)
			Label.Font = Enum.Font.GothamSemibold
			Label.Text = text
			Label.TextColor3 = Color3.fromRGB(225, 225, 225)
			Label.TextSize = 15.000

			ToggleImage.Name = "ToggleImage"
			ToggleImage.Parent = Toggle
			ToggleImage.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
			ToggleImage.Position = UDim2.new(0, 415, 0, 5)
			ToggleImage.Size = UDim2.new(0, 45, 0, 20)

			UICorner_3.CornerRadius = UDim.new(0, 10)
			UICorner_3.Parent = ToggleImage

			Circle.Name = "Circle"
			Circle.Parent = ToggleImage
			Circle.BackgroundColor3 = Color3.fromRGB(227, 60, 60)
			Circle.Position = UDim2.new(0, 2, 0, 2)
			Circle.Size = UDim2.new(0, 16, 0, 16)

			UICorner_4.CornerRadius = UDim.new(0, 10)
			UICorner_4.Parent = Circle

			Button.MouseButton1Click:Connect(function()
				if toggled == false then
					toggled = true
					Circle:TweenPosition(UDim2.new(0,27,0,2),"Out","Sine",0.2,true)
					TweenService:Create(
						Circle,
						TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(0, 108, 219)}
					):Play()
				else
					toggled = false
					Circle:TweenPosition(UDim2.new(0,2,0,2),"Out","Sine",0.2,true)
					TweenService:Create(
						Circle,
						TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(227, 60, 110)}
					):Play()
				end
				pcall(callback,toggled)
			end)

			if config == true then
				toggled = true
				Circle:TweenPosition(UDim2.new(0,27,0,2),"Out","Sine",0.4,true)
				TweenService:Create(
					Circle,
					TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
					{BackgroundColor3 = Color3.fromRGB(0, 108, 219)}
				):Play()
				pcall(callback,toggled)
			end
		end
		function main:Dropdown(text,option,callback)
			local isdropping = false
			local Dropdown = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local DropTitle = Instance.new("TextLabel")
			local DropScroll = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")
			local DropButton = Instance.new("TextButton")
			local DropImage = Instance.new("ImageLabel")
			
			Dropdown.Name = "Dropdown"
			Dropdown.Parent = MainFramePage
			Dropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			Dropdown.ClipsDescendants = true
			Dropdown.Size = UDim2.new(0, 470, 0, 31)
			
			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = Dropdown
			
			DropTitle.Name = "DropTitle"
			DropTitle.Parent = Dropdown
			DropTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropTitle.BackgroundTransparency = 1.000
			DropTitle.Size = UDim2.new(0, 470, 0, 31)
			DropTitle.Font = Enum.Font.GothamSemibold
			DropTitle.Text = text.. " : "
			DropTitle.TextColor3 = Color3.fromRGB(225, 225, 225)
			DropTitle.TextSize = 15.000
			
			DropScroll.Name = "DropScroll"
			DropScroll.Parent = DropTitle
			DropScroll.Active = true
			DropScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropScroll.BackgroundTransparency = 1.000
			DropScroll.BorderSizePixel = 0
			DropScroll.Position = UDim2.new(0, 0, 0, 31)
			DropScroll.Size = UDim2.new(0, 470, 0, 100)
			DropScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
			DropScroll.ScrollBarThickness = 3
			
			UIListLayout.Parent = DropScroll
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 5)
			
			UIPadding.Parent = DropScroll
			UIPadding.PaddingLeft = UDim.new(0, 5)
			UIPadding.PaddingTop = UDim.new(0, 5)
			
			DropImage.Name = "DropImage"
			DropImage.Parent = Dropdown
			DropImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropImage.BackgroundTransparency = 1.000
			DropImage.Position = UDim2.new(0, 445, 0, 6)
			DropImage.Rotation = 180.000
			DropImage.Size = UDim2.new(0, 20, 0, 20)
			DropImage.Image = "rbxassetid://6031090990"
			
			DropButton.Name = "DropButton"
			DropButton.Parent = Dropdown
			DropButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropButton.BackgroundTransparency = 1.000
			DropButton.Size = UDim2.new(0, 470, 0, 31)
			DropButton.Font = Enum.Font.SourceSans
			DropButton.Text = ""
			DropButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			DropButton.TextSize = 14.000

			for i,v in next,option do
				local Item = Instance.new("TextButton")

				Item.Name = "Item"
				Item.Parent = DropScroll
				Item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Item.BackgroundTransparency = 1.000
				Item.Size = UDim2.new(0, 460, 0, 26)
				Item.Font = Enum.Font.GothamSemibold
				Item.Text = tostring(v)
				Item.TextColor3 = Color3.fromRGB(225, 225, 225)
				Item.TextSize = 13.000
				Item.TextTransparency = 0.500

				Item.MouseEnter:Connect(function()
					TweenService:Create(
						Item,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
				end)

				Item.MouseLeave:Connect(function()
					TweenService:Create(
						Item,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 0.5}
					):Play()
				end)

				Item.MouseButton1Click:Connect(function()
					isdropping = false
					Dropdown:TweenSize(UDim2.new(0,470,0,31),"Out","Quad",0.3,true)
					TweenService:Create(
						DropImage,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
					callback(Item.Text)
					DropTitle.Text = text.." : "..Item.Text
				end)
			end

			DropScroll.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 10)

			DropButton.MouseButton1Click:Connect(function()
				if isdropping == false then
					isdropping = true
					Dropdown:TweenSize(UDim2.new(0,470,0,131),"Out","Quad",0.3,true)
					TweenService:Create(
						DropImage,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
				else
					isdropping = false
					Dropdown:TweenSize(UDim2.new(0,470,0,31),"Out","Quad",0.3,true)
					TweenService:Create(
						DropImage,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
				end
			end)

			local dropfunc = {}
			function dropfunc:Add(t)
				local Item = Instance.new("TextButton")
				Item.Name = "Item"
				Item.Parent = DropScroll
				Item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Item.BackgroundTransparency = 1.000
				Item.Size = UDim2.new(0, 470, 0, 26)
				Item.Font = Enum.Font.GothamSemibold
				Item.Text = tostring(t)
				Item.TextColor3 = Color3.fromRGB(225, 225, 225)
				Item.TextSize = 13.000
				Item.TextTransparency = 0.500

				Item.MouseEnter:Connect(function()
					TweenService:Create(
						Item,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
				end)

				Item.MouseLeave:Connect(function()
					TweenService:Create(
						Item,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 0.5}
					):Play()
				end)

				Item.MouseButton1Click:Connect(function()
					isdropping = false
					Dropdown:TweenSize(UDim2.new(0,470,0,31),"Out","Quad",0.3,true)
					TweenService:Create(
						DropImage,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
					callback(Item.Text)
					DropTitle.Text = text.." : "..Item.Text
				end)
			end
			function dropfunc:Clear()
				DropTitle.Text = tostring(text).." : "
				isdropping = false
				Dropdown:TweenSize(UDim2.new(0,470,0,31),"Out","Quad",0.3,true)
				TweenService:Create(
					DropImage,
					TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
					{Rotation = 180}
				):Play()
				for i,v in next, DropScroll:GetChildren() do
					if v:IsA("TextButton") then
						v:Destroy()
					end
				end
			end
			return dropfunc
		end

		function main:Slider(text,min,max,set,callback)
			local Slider = Instance.new("Frame")
			local slidercorner = Instance.new("UICorner")
			local sliderr = Instance.new("Frame")
			local sliderrcorner = Instance.new("UICorner")
			local SliderLabel = Instance.new("TextLabel")
			local HAHA = Instance.new("Frame")
			local AHEHE = Instance.new("TextButton")
			local bar = Instance.new("Frame")
			local bar1 = Instance.new("Frame")
			local bar1corner = Instance.new("UICorner")
			local barcorner = Instance.new("UICorner")
			local circlebar = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local slidervalue = Instance.new("Frame")
			local valuecorner = Instance.new("UICorner")
			local TextBox = Instance.new("TextBox")
			local UICorner_2 = Instance.new("UICorner")

			Slider.Name = "Slider"
			Slider.Parent = MainFramePage
			Slider.BackgroundColor3 = Color3.fromRGB(0, 108, 219)
			Slider.BackgroundTransparency = 0
			Slider.Size = UDim2.new(0, 470, 0, 51)

			slidercorner.CornerRadius = UDim.new(0, 5)
			slidercorner.Name = "slidercorner"
			slidercorner.Parent = Slider

			sliderr.Name = "sliderr"
			sliderr.Parent = Slider
			sliderr.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			sliderr.Position = UDim2.new(0, 1, 0, 1)
			sliderr.Size = UDim2.new(0, 468, 0, 49)

			sliderrcorner.CornerRadius = UDim.new(0, 5)
			sliderrcorner.Name = "sliderrcorner"
			sliderrcorner.Parent = sliderr

			SliderLabel.Name = "SliderLabel"
			SliderLabel.Parent = sliderr
			SliderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderLabel.BackgroundTransparency = 1.000
			SliderLabel.Position = UDim2.new(0, 15, 0, 0)
			SliderLabel.Size = UDim2.new(0, 180, 0, 26)
			SliderLabel.Font = Enum.Font.GothamSemibold
			SliderLabel.Text = text
			SliderLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
			SliderLabel.TextSize = 16.000
			SliderLabel.TextTransparency = 0
			SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

			HAHA.Name = "HAHA"
			HAHA.Parent = sliderr
			HAHA.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HAHA.BackgroundTransparency = 1.000
			HAHA.Size = UDim2.new(0, 468, 0, 29)

			AHEHE.Name = "AHEHE"
			AHEHE.Parent = sliderr
			AHEHE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			AHEHE.BackgroundTransparency = 1.000
			AHEHE.Position = UDim2.new(0, 10, 0, 35)
			AHEHE.Size = UDim2.new(0, 448, 0, 5)
			AHEHE.Font = Enum.Font.SourceSans
			AHEHE.Text = ""
			AHEHE.TextColor3 = Color3.fromRGB(0, 0, 0)
			AHEHE.TextSize = 14.000

			bar.Name = "bar"
			bar.Parent = AHEHE
			bar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			bar.Size = UDim2.new(0, 448, 0, 5)

			bar1.Name = "bar1"
			bar1.Parent = bar
			bar1.BackgroundColor3 = Color3.fromRGB(0, 108, 219)
			bar1.BackgroundTransparency = 0
			bar1.Size = UDim2.new(set/max, 0, 0, 5)

			bar1corner.CornerRadius = UDim.new(0, 5)
			bar1corner.Name = "bar1corner"
			bar1corner.Parent = bar1

			barcorner.CornerRadius = UDim.new(0, 5)
			barcorner.Name = "barcorner"
			barcorner.Parent = bar

			circlebar.Name = "circlebar"
			circlebar.Parent = bar1
			circlebar.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
			circlebar.Position = UDim2.new(1, -2, 0, -3)
			circlebar.Size = UDim2.new(0, 10, 0, 10)

			UICorner.CornerRadius = UDim.new(0, 100)
			UICorner.Parent = circlebar

			slidervalue.Name = "slidervalue"
			slidervalue.Parent = sliderr
			slidervalue.BackgroundColor3 = Color3.fromRGB(0, 108, 219)
			slidervalue.BackgroundTransparency = 0
			slidervalue.Position = UDim2.new(0, 395, 0, 5)
			slidervalue.Size = UDim2.new(0, 65, 0, 18)

			valuecorner.CornerRadius = UDim.new(0, 5)
			valuecorner.Name = "valuecorner"
			valuecorner.Parent = slidervalue

			TextBox.Parent = slidervalue
			TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			TextBox.Position = UDim2.new(0, 1, 0, 1)
			TextBox.Size = UDim2.new(0, 63, 0, 16)
			TextBox.Font = Enum.Font.GothamSemibold
			TextBox.TextColor3 = Color3.fromRGB(225, 225, 225)
			TextBox.TextSize = 9.000
			TextBox.Text = set
			TextBox.TextTransparency = 0

			UICorner_2.CornerRadius = UDim.new(0, 5)
			UICorner_2.Parent = TextBox

			local mouse = game.Players.LocalPlayer:GetMouse()
			local uis = game:GetService("UserInputService")

			if Value == nil then
				Value = set
				pcall(function()
					callback(Value)
				end)
			end
			
			AHEHE.MouseButton1Down:Connect(function()
				Value = math.floor((((tonumber(max) - tonumber(min)) / 448) * bar1.AbsoluteSize.X) + tonumber(min)) or 0
				pcall(function()
					callback(Value)
				end)
				bar1.Size = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X, 0, 448), 0, 5)
				circlebar.Position = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X - 2, 0, 438), 0, -3)
				moveconnection = mouse.Move:Connect(function()
					TextBox.Text = Value
					Value = math.floor((((tonumber(max) - tonumber(min)) / 448) * bar1.AbsoluteSize.X) + tonumber(min))
					pcall(function()
						callback(Value)
					end)
					bar1.Size = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X, 0, 448), 0, 5)
					circlebar.Position = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X - 2, 0, 438), 0, -3)
				end)
				releaseconnection = uis.InputEnded:Connect(function(Mouse)
					if Mouse.UserInputType == Enum.UserInputType.MouseButton1 or Mouse.UserInputType == Enum.UserInputType.Touch then
						Value = math.floor((((tonumber(max) - tonumber(min)) / 448) * bar1.AbsoluteSize.X) + tonumber(min))
						pcall(function()
							callback(Value)
						end)
						bar1.Size = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X, 0, 448), 0, 5)
						circlebar.Position = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X - 2, 0, 438), 0, -3)
						moveconnection:Disconnect()
						releaseconnection:Disconnect()
					end
				end)
			end)
			releaseconnection = uis.InputEnded:Connect(function(Mouse)
				if Mouse.UserInputType == Enum.UserInputType.MouseButton1 or Mouse.UserInputType == Enum.UserInputType.Touch  then
					Value = math.floor((((tonumber(max) - tonumber(min)) / 448) * bar1.AbsoluteSize.X) + tonumber(min))
					TextBox.Text = Value
				end
			end)

			TextBox.FocusLost:Connect(function()
				if tonumber(TextBox.Text) > max then
					TextBox.Text  = max
				end
				bar1.Size = UDim2.new((TextBox.Text or 0) / max, 0, 0, 5)
				circlebar.Position = UDim2.new(1, -2, 0, -3)
				TextBox.Text = tostring(TextBox.Text and math.floor( (TextBox.Text / max) * (max - min) + min) )
				pcall(callback, TextBox.Text)
			end)
		end

		function main:Textbox(text,disappear,callback)
			local Textbox = Instance.new("Frame")
			local TextboxCorner = Instance.new("UICorner")
			local Textboxx = Instance.new("Frame")
			local TextboxxCorner = Instance.new("UICorner")
			local TextboxLabel = Instance.new("TextLabel")
			local txtbtn = Instance.new("TextButton")
			local RealTextbox = Instance.new("TextBox")
			local UICorner = Instance.new("UICorner")

			Textbox.Name = "Textbox"
			Textbox.Parent = MainFramePage
			Textbox.BackgroundColor3 = Color3.fromRGB(0, 108, 219)
			Textbox.BackgroundTransparency = 0
			Textbox.Size = UDim2.new(0, 470, 0, 31)

			TextboxCorner.CornerRadius = UDim.new(0, 5)
			TextboxCorner.Name = "TextboxCorner"
			TextboxCorner.Parent = Textbox

			Textboxx.Name = "Textboxx"
			Textboxx.Parent = Textbox
			Textboxx.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			Textboxx.Position = UDim2.new(0, 1, 0, 1)
			Textboxx.Size = UDim2.new(0, 468, 0, 29)

			TextboxxCorner.CornerRadius = UDim.new(0, 5)
			TextboxxCorner.Name = "TextboxxCorner"
			TextboxxCorner.Parent = Textboxx

			TextboxLabel.Name = "TextboxLabel"
			TextboxLabel.Parent = Textbox
			TextboxLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextboxLabel.BackgroundTransparency = 1.000
			TextboxLabel.Position = UDim2.new(0, 15, 0, 0)
			TextboxLabel.Text = text
			TextboxLabel.Size = UDim2.new(0, 145, 0, 31)
			TextboxLabel.Font = Enum.Font.GothamSemibold
			TextboxLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
			TextboxLabel.TextSize = 16.000
			TextboxLabel.TextTransparency = 0
			TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left

			txtbtn.Name = "txtbtn"
			txtbtn.Parent = Textbox
			txtbtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			txtbtn.BackgroundTransparency = 1.000
			txtbtn.Position = UDim2.new(0, 1, 0, 1)
			txtbtn.Size = UDim2.new(0, 468, 0, 29)
			txtbtn.Font = Enum.Font.SourceSans
			txtbtn.Text = ""
			txtbtn.TextColor3 = Color3.fromRGB(0, 0, 0)
			txtbtn.TextSize = 14.000

			RealTextbox.Name = "RealTextbox"
			RealTextbox.Parent = Textbox
			RealTextbox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			RealTextbox.BackgroundTransparency = 0
			RealTextbox.Position = UDim2.new(0, 360, 0, 4)
			RealTextbox.Size = UDim2.new(0, 100, 0, 24)
			RealTextbox.Font = Enum.Font.GothamSemibold
			RealTextbox.Text = ""
			RealTextbox.TextColor3 = Color3.fromRGB(225, 225, 225)
			RealTextbox.TextSize = 11.000
			RealTextbox.TextTransparency = 0

			RealTextbox.FocusLost:Connect(function()
				callback(RealTextbox.Text)
				if disappear then
					RealTextbox.Text = ""
				end
			end)

			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = RealTextbox
		end
		function main:Label(text)
			local Label = Instance.new("TextLabel")
			local PaddingLabel = Instance.new("UIPadding")
			local labelfunc = {}
	
			Label.Name = "Label"
			Label.Parent = MainFramePage
			Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Label.BackgroundTransparency = 1.000
			Label.Size = UDim2.new(0, 470, 0, 20)
			Label.Font = Enum.Font.GothamSemibold
			Label.TextColor3 = Color3.fromRGB(225, 225, 225)
			Label.TextSize = 16.000
			Label.Text = text
			Label.TextXAlignment = Enum.TextXAlignment.Left

			PaddingLabel.PaddingLeft = UDim.new(0,15)
			PaddingLabel.Parent = Label
			PaddingLabel.Name = "PaddingLabel"
	
			function labelfunc:Set(newtext)
				Label.Text = newtext
			end
			return labelfunc
		end

		function main:Seperator(text)
			local Seperator = Instance.new("Frame")
			local Sep1 = Instance.new("Frame")
			local Sep2 = Instance.new("TextLabel")
			local Sep3 = Instance.new("Frame")
			
			Seperator.Name = "Seperator"
			Seperator.Parent = MainFramePage
			Seperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Seperator.BackgroundTransparency = 1.000
			Seperator.Size = UDim2.new(0, 470, 0, 20)
			
			Sep1.Name = "Sep1"
			Sep1.Parent = Seperator
			Sep1.BackgroundColor3 = Color3.fromRGB(0, 108, 219)
			Sep1.BorderSizePixel = 0
			Sep1.Position = UDim2.new(0, 0, 0, 10)
			Sep1.Size = UDim2.new(0, 80, 0, 1)
			
			Sep2.Name = "Sep2"
			Sep2.Parent = Seperator
			Sep2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Sep2.BackgroundTransparency = 1.000
			Sep2.Position = UDim2.new(0, 185, 0, 0)
			Sep2.Size = UDim2.new(0, 100, 0, 20)
			Sep2.Font = Enum.Font.GothamSemibold
			Sep2.Text = text
			Sep2.TextColor3 = Color3.fromRGB(255, 255, 255)
			Sep2.TextSize = 14.000
			
			Sep3.Name = "Sep3"
			Sep3.Parent = Seperator
			Sep3.BackgroundColor3 = Color3.fromRGB(0, 108, 219)
			Sep3.BorderSizePixel = 0
			Sep3.Position = UDim2.new(0, 390, 0, 10)
			Sep3.Size = UDim2.new(0, 80, 0, 1)
		end

		function main:Line()
			local Linee = Instance.new("Frame")
			local Line = Instance.new("Frame")
			
			Linee.Name = "Linee"
			Linee.Parent = MainFramePage
			Linee.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Linee.BackgroundTransparency = 1.000
			Linee.Position = UDim2.new(0, 0, 0.119999997, 0)
			Linee.Size = UDim2.new(0, 470, 0, 20)
			
			Line.Name = "Line"
			Line.Parent = Linee
			Line.BackgroundColor3 = Color3.fromRGB(0, 108, 219)
			Line.BorderSizePixel = 0
			Line.Position = UDim2.new(0, 0, 0, 10)
			Line.Size = UDim2.new(0, 470, 0, 1)
		end
		return main
	end
	return uitab
end


local Library = VectorHub:Window("x2N Hub","","",Enum.KeyCode.F1);
if _G.Mode == "English" then
page1 = Library:Tab("Main")
page1:Seperator("Main")
else
_G.Mode = "Thai"
page1 = Library:Tab("Trang chủ")
page1:Seperator("Trang chủ")
end
if _G.Mode == "English" then
page2 = Library:Tab("Misc")
page2:Seperator("Misc")
else
_G.Mode = "Thai"
page2 = Library:Tab("khác")
page2:Seperator("khác")
end
if _G.Mode == "English" then
page1:Toggle("Auto Parry",false,function(value)

local function startAutoParry()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local runService = game:GetService("RunService")
    local parryButtonPress = replicatedStorage.Remotes.ParryButtonPress
    local ballsFolder = workspace:WaitForChild("Balls")

  
    local function onCharacterAdded(newCharacter)
        character = newCharacter
    end

    player.CharacterAdded:Connect(onCharacterAdded)

    local focusedBall = nil  

    local function chooseNewFocusedBall()
        local balls = ballsFolder:GetChildren()
        focusedBall = nil
        for _, ball in ipairs(balls) do
            if ball:GetAttribute("realBall") == true then
                focusedBall = ball
                break
            end
        end
    end

    chooseNewFocusedBall()

    local function timeUntilImpact(ballVelocity, distanceToPlayer, playerVelocity)
        local directionToPlayer = (character.HumanoidRootPart.Position - focusedBall.Position).Unit
        local velocityTowardsPlayer = ballVelocity:Dot(directionToPlayer) - playerVelocity:Dot(directionToPlayer)
        
        if velocityTowardsPlayer <= 0 then
            return math.huge
        end
        
        local distanceToBeCovered = distanceToPlayer - 24 
        return distanceToBeCovered / velocityTowardsPlayer
    end

    local BASE_THRESHOLD = 0.15
    local VELOCITY_SCALING_FACTOR = 0.002

    local function getDynamicThreshold(ballVelocityMagnitude)
        local adjustedThreshold = BASE_THRESHOLD - (ballVelocityMagnitude * VELOCITY_SCALING_FACTOR)
        return math.max(0.12, adjustedThreshold)
    end

    local function checkBallDistance()
        if not character:FindFirstChild("Highlight") then return end
        local charPos = character.PrimaryPart.Position
        local charVel = character.PrimaryPart.Velocity

        if focusedBall and not focusedBall.Parent then
            chooseNewFocusedBall()
        end

        if not focusedBall then return end

        local ball = focusedBall
        local distanceToPlayer = (ball.Position - charPos).Magnitude

        if distanceToPlayer <= 1 then
	        parryButtonPress:Fire()
	    return 
	end

      
        local timeToImpact = timeUntilImpact(ball.Velocity, distanceToPlayer, charVel)
        local dynamicThreshold = getDynamicThreshold(ball.Velocity.Magnitude)

        if timeToImpact < dynamicThreshold then
            parryButtonPress:Fire()
        end
    end
    heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
        checkBallDistance()
    end)
end

local function stopAutoParry()
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
end
if value == true then
startAutoParry()
elseif value == false  then
    stopAutoParry()
end
end)
else
    _G.Mode = "Thai"
    page1:Toggle("Tự động chặn bóng",false,function(value)

        local function startAutoParry()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local replicatedStorage = game:GetService("ReplicatedStorage")
            local runService = game:GetService("RunService")
            local parryButtonPress = replicatedStorage.Remotes.ParryButtonPress
            local ballsFolder = workspace:WaitForChild("Balls")
        
          
            local function onCharacterAdded(newCharacter)
                character = newCharacter
            end
        
            player.CharacterAdded:Connect(onCharacterAdded)
        
            local focusedBall = nil  
        
            local function chooseNewFocusedBall()
                local balls = ballsFolder:GetChildren()
                focusedBall = nil
                for _, ball in ipairs(balls) do
                    if ball:GetAttribute("realBall") == true then
                        focusedBall = ball
                        break
                    end
                end
            end
        
            chooseNewFocusedBall()
        
            local function timeUntilImpact(ballVelocity, distanceToPlayer, playerVelocity)
                local directionToPlayer = (character.HumanoidRootPart.Position - focusedBall.Position).Unit
                local velocityTowardsPlayer = ballVelocity:Dot(directionToPlayer) - playerVelocity:Dot(directionToPlayer)
                
                if velocityTowardsPlayer <= 0 then
                    return math.huge
                end
                
                local distanceToBeCovered = distanceToPlayer - 24 
                return distanceToBeCovered / velocityTowardsPlayer
            end
        
            local BASE_THRESHOLD = 0.15
            local VELOCITY_SCALING_FACTOR = 0.002
        
            local function getDynamicThreshold(ballVelocityMagnitude)
                local adjustedThreshold = BASE_THRESHOLD - (ballVelocityMagnitude * VELOCITY_SCALING_FACTOR)
                return math.max(0.12, adjustedThreshold)
            end
        
            local function checkBallDistance()
                if not character:FindFirstChild("Highlight") then return end
                local charPos = character.PrimaryPart.Position
                local charVel = character.PrimaryPart.Velocity
        
                if focusedBall and not focusedBall.Parent then
                    chooseNewFocusedBall()
                end
        
                if not focusedBall then return end
        
                local ball = focusedBall
                local distanceToPlayer = (ball.Position - charPos).Magnitude
        
                if distanceToPlayer <= 1 then
                    parryButtonPress:Fire()
                return 
            end
        
              
                local timeToImpact = timeUntilImpact(ball.Velocity, distanceToPlayer, charVel)
                local dynamicThreshold = getDynamicThreshold(ball.Velocity.Magnitude)
        
                if timeToImpact < dynamicThreshold then
                    parryButtonPress:Fire()
                end
            end
            heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
                checkBallDistance()
            end)
        end
        
        local function stopAutoParry()
            if heartbeatConnection then
                heartbeatConnection:Disconnect()
                heartbeatConnection = nil
            end
        end
        if value == true then
        startAutoParry()
        elseif value == false  then
            stopAutoParry()
        end
        end)
    end
    if _G.Mode == "English" then
page1:Toggle("Auto Parry TP To Ball",_G.ParryballTPP,function(value)
    _G.ParryballTPP = value
    
   local player = game.Players.LocalPlayer
   local character = player.Character or player.CharacterAdded:Wait()
   local replicatedStorage = game:GetService("ReplicatedStorage")
   local runService = game:GetService("RunService")
   local parryButtonPress = replicatedStorage.Remotes.ParryButtonPress
   local ballsFolder = workspace:WaitForChild("Balls")


   local function onCharacterAdded(newCharacter)
       character = newCharacter
   end

   player.CharacterAdded:Connect(onCharacterAdded)

   local focusedBall = nil
   

posrandom = 0
randomposenelfastfarm = 0
while _G.ParryballTPP do task.wait(0)
       local balls = ballsFolder:GetChildren()
       focusedBall = nil
       for _, ball in ipairs(balls) do
           if ball:GetAttribute("realBall") == true then
           if  character:FindFirstChild("Highlight") then 
            local newCFrame = CFrame.new(ball.Position.X, ball.Position.Y, ball.Position.Z) -- เพิ่มตำแหน่ง Y เพื่อห่างจากบอล
             parryButtonPress:Fire()
             spawn(function()
               if posrandom <= 1 then
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame * CFrame.new(5, -5, 0)
              --parryButtonPress:Fire()
              posrandom = posrandom + 0.1
           elseif posrandom >= 1 and posrandom <= 2 then
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame * CFrame.new(0, 5, 5)
             -- parryButtonPress:Fire()
              posrandom = posrandom + 0.1
           elseif posrandom >= 2 and posrandom <= 3 then
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame * CFrame.new(5, -5, 0)
              -- parryButtonPress:Fire()
               posrandom = posrandom + 0.1
           elseif posrandom >= 3 and posrandom <= 4 then
             game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame * CFrame.new(0, 5, 5)
             -- parryButtonPress:Fire()
               posrandom = posrandom + 0.1
           elseif posrandom >= 4 and posrandom <= 5 then
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame * CFrame.new(0, -5, 5)
              parryButtonPress:Fire()
               posrandom = 0
                       end
                   end)
               end
           end
       end
   end
end)
else
    _G.Mode = "Thai"
    page1:Toggle("Tự động chặn bóng cong vênh",_G.ParryballTPP,function(value)
        _G.ParryballTPP = value
        
       local player = game.Players.LocalPlayer
       local character = player.Character or player.CharacterAdded:Wait()
       local replicatedStorage = game:GetService("ReplicatedStorage")
       local runService = game:GetService("RunService")
       local parryButtonPress = replicatedStorage.Remotes.ParryButtonPress
       local ballsFolder = workspace:WaitForChild("Balls")
    
    
       local function onCharacterAdded(newCharacter)
           character = newCharacter
       end
    
       player.CharacterAdded:Connect(onCharacterAdded)
    
       local focusedBall = nil
       

    posrandom = 0
    randomposenelfastfarm = 0
    while _G.ParryballTPP do task.wait(0)
           local balls = ballsFolder:GetChildren()
           focusedBall = nil
           for _, ball in ipairs(balls) do
               if ball:GetAttribute("realBall") == true then
               if  character:FindFirstChild("Highlight") then 
                local newCFrame = CFrame.new(ball.Position.X, ball.Position.Y, ball.Position.Z) -- เพิ่มตำแหน่ง Y เพื่อห่างจากบอล
                 parryButtonPress:Fire()
                 spawn(function()
                   if posrandom <= 1 then
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame * CFrame.new(5, -5, 0)
                  --parryButtonPress:Fire()
                  
                  posrandom = posrandom + 0.1
               elseif posrandom >= 1 and posrandom <= 2 then
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame * CFrame.new(0, 5, 5)
                 -- parryButtonPress:Fire()
                  posrandom = posrandom + 0.1
               elseif posrandom >= 2 and posrandom <= 3 then
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame * CFrame.new(5, -5, 0)
                  -- parryButtonPress:Fire()
                   posrandom = posrandom + 0.1
               elseif posrandom >= 3 and posrandom <= 4 then
                 game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame * CFrame.new(0, 5, 5)
                 -- parryButtonPress:Fire()
                   posrandom = posrandom + 0.1
               elseif posrandom >= 4 and posrandom <= 5 then
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame * CFrame.new(0, -5, 5)
                  parryButtonPress:Fire()
                   posrandom = 0
                           end
                       end)
                   end
               end
           end
       end
    end)
end
if _G.Mode == "English" then
page1:Toggle("TweenFollowBall",_G.FollowBall,function(value)
_G.FollowBall = value
function two(gotoCFrame) --- Tween
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
    end)
    if (game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - gotoCFrame.Position).Magnitude <= 200 then
        pcall(function()
            tweenz:Cancel()
        end)
        game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.CFrame = gotoCFrame
    else
        local tween_s = game:service "TweenService"
        local info = TweenInfo.new(
            (game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - gotoCFrame.Position)
            .Magnitude /
            325, Enum.EasingStyle.Linear)
        tween, err = pcall(function()
            tweenz = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, { CFrame = gotoCFrame })
            tweenz:Play()
        end)
        if not tween then return err end
    end
    function _TweenCanCle()
        tweenz:Cancel()
    end
end

   local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local runService = game:GetService("RunService")
    local parryButtonPress = replicatedStorage.Remotes.ParryButtonPress
    local ballsFolder = workspace:WaitForChild("Balls")


    local function onCharacterAdded(newCharacter)
        character = newCharacter
    end

    player.CharacterAdded:Connect(onCharacterAdded)

    local focusedBall = nil

while _G.FollowBall do task.wait()
        local balls = ballsFolder:GetChildren()
        focusedBall = nil
        for _, ball in ipairs(balls) do
            if ball:GetAttribute("realBall") == true then
			local newCFrame = CFrame.new(ball.Position.X, ball.Position.Y -5, ball.Position.Z)
                 two(newCFrame * CFrame.new(0,5,5))
            end
        end
     end
end)
else
    _G.Mode = "Thai"
    page1:Toggle("Theo bóng",_G.FollowBall,function(value)
        _G.FollowBall = value
        function two(gotoCFrame) --- Tween
            pcall(function()
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            end)
            if (game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - gotoCFrame.Position).Magnitude <= 200 then
                pcall(function()
                    tweenz:Cancel()
                end)
                game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.CFrame = gotoCFrame
            else
                local tween_s = game:service "TweenService"
                local info = TweenInfo.new(
                    (game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - gotoCFrame.Position)
                    .Magnitude /
                    325, Enum.EasingStyle.Linear)
                tween, err = pcall(function()
                    tweenz = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, { CFrame = gotoCFrame })
                    tweenz:Play()
                end)
                if not tween then return err end
            end
            function _TweenCanCle()
                tweenz:Cancel()
            end
        end
        
           local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local replicatedStorage = game:GetService("ReplicatedStorage")
            local runService = game:GetService("RunService")
            local parryButtonPress = replicatedStorage.Remotes.ParryButtonPress
            local ballsFolder = workspace:WaitForChild("Balls")
        
        
            local function onCharacterAdded(newCharacter)
                character = newCharacter
            end
        
            player.CharacterAdded:Connect(onCharacterAdded)
        
            local focusedBall = nil
        
        while _G.FollowBall do task.wait()
                local balls = ballsFolder:GetChildren()
                focusedBall = nil
                for _, ball in ipairs(balls) do
                    if ball:GetAttribute("realBall") == true then
                    local newCFrame = CFrame.new(ball.Position.X, ball.Position.Y -5, ball.Position.Z)
                         two(newCFrame * CFrame.new(0,5,5))
                    end
                end
             end
        end)
    end
    if _G.Mode == "English" then
page1:Toggle("AI Wallk To Ball",_G.AIWALK,function(value)
    _G.AIWALK = value
    game:GetService("StarterGui"):SetCore("SendNotification",{Title = "VectorHub",Text = "Open When Game Start",Icon = "rbxassetid://14645512457",Duration = 1})
    while _G.AIWALK do task.wait()
    
        repeat task.wait()
        local ballsFolder = workspace:WaitForChild("Balls")
        
        local balls = ballsFolder:GetChildren()
        local ballsFolder = workspace:WaitForChild("Balls")
        local balls = ballsFolder:GetChildren()
        
        local localPlayer = game.Players.LocalPlayer
        local humanoidRootPart = localPlayer.Character:WaitForChild("HumanoidRootPart")
        
        local randomIndex = math.random(1, #balls)
        local selectedBall = balls[randomIndex]
        
        
        local cameraCFrame = CFrame.new(
            workspace.CurrentCamera.CFrame.p,  
            selectedBall.Position 
        )
        workspace.CurrentCamera.CFrame = cameraCFrame
       
    
    for _, ball in pairs(balls) do
        local ballPosition = ball.Position
        local playerPosition = humanoidRootPart.Position
        local distance = (ballPosition - playerPosition).magnitude
        
        if distance > 25 then
            keypress(0x57) -- ส่งคำสั่งกดปุ่ม W
        elseif distance < 25 then
            keyrelease(0x57) -- ส่งคำสั่งปล่อยปุ่ม W
        end
    end
        until _G.AIWALK == false
        end
        if _G.AIWALK == false then
            keyrelease(0x57)
        end
end)
else
    _G.Mode = "Thai"
    page1:Toggle("Tự động đi về phía quả bóng",_G.AIWALK,function(value)
        _G.AIWALK = value
        game:GetService("StarterGui"):SetCore("SendNotification",{Title = "VectorHub",Text = "เปิดตอนเกมเริ่มเท่านั้น",Icon = "rbxassetid://14645512457",Duration = 1})
        while _G.AIWALK do task.wait()
        
            repeat task.wait()
            local ballsFolder = workspace:WaitForChild("Balls")
            
            local balls = ballsFolder:GetChildren()
            local ballsFolder = workspace:WaitForChild("Balls")
            local balls = ballsFolder:GetChildren()
            
            local localPlayer = game.Players.LocalPlayer
            local humanoidRootPart = localPlayer.Character:WaitForChild("HumanoidRootPart")
            
            local randomIndex = math.random(1, #balls)
            local selectedBall = balls[randomIndex]
            
            
            local cameraCFrame = CFrame.new(
                workspace.CurrentCamera.CFrame.p,  
                selectedBall.Position 
            )
            workspace.CurrentCamera.CFrame = cameraCFrame
           
        
        for _, ball in pairs(balls) do
            local ballPosition = ball.Position
            local playerPosition = humanoidRootPart.Position
            local distance = (ballPosition - playerPosition).magnitude
            
            if distance > 25 then
                keypress(0x57) -- ส่งคำสั่งกดปุ่ม W
            elseif distance < 25 then
                keyrelease(0x57) -- ส่งคำสั่งปล่อยปุ่ม W
            end
        end
            until _G.AIWALK == false
            end
            if _G.AIWALK == false then
                keyrelease(0x57)
            end
    end)
end
if _G.Mode == "English" then
page1:Toggle("FocusBall",_G.FocusBall,function(value)
    _G.FocusBall = value
while _G.FocusBall do task.wait(0)
    local ballsFolder = workspace:WaitForChild("Balls")
      local balls = ballsFolder:GetChildren()
      local ballsFolder = workspace:WaitForChild("Balls")
      local balls = ballsFolder:GetChildren()
      
      local localPlayer = game.Players.LocalPlayer
      local humanoidRootPart = localPlayer.Character:WaitForChild("HumanoidRootPart")
      
      local randomIndex = math.random(1, #balls)
      local selectedBall = balls[randomIndex]
      
      
      local cameraCFrame = CFrame.new(
          workspace.CurrentCamera.CFrame.p,  
          selectedBall.Position 
      )
      workspace.CurrentCamera.CFrame = cameraCFrame
     end
    end)
else
    page1:Toggle("โฟกัสบอล",_G.FocusBall,function(value)
        _G.FocusBall = value
    while _G.FocusBall do task.wait(0)
        local ballsFolder = workspace:WaitForChild("Balls")
          local balls = ballsFolder:GetChildren()
          local ballsFolder = workspace:WaitForChild("Balls")
          local balls = ballsFolder:GetChildren()
          
          local localPlayer = game.Players.LocalPlayer
          local humanoidRootPart = localPlayer.Character:WaitForChild("HumanoidRootPart")
          
          local randomIndex = math.random(1, #balls)
          local selectedBall = balls[randomIndex]
          
          
          local cameraCFrame = CFrame.new(
              workspace.CurrentCamera.CFrame.p,  
              selectedBall.Position 
          )
          workspace.CurrentCamera.CFrame = cameraCFrame
         end
        end)
end



if _G.Mode == "English" then
page1:Button("Open Box Sword Normal",function()
game:GetService("ReplicatedStorage").Remotes.Store.RequestOpenSwordBox:InvokeServer()
end)
page1:Button("Open Box Explosion Normal",function()
game:GetService("ReplicatedStorage").Remotes.Store.RequestOpenExplosionBox:InvokeServer()
end)
else
    _G.Mode = "Thai"
    page1:Button("Mở hộp kiếm",function()
        game:GetService("ReplicatedStorage").Remotes.Store.RequestOpenSwordBox:InvokeServer()
        end)
        page1:Button("เปิดกล่องเอฟเฟกต์การตาย",function()
        game:GetService("ReplicatedStorage").Remotes.Store.RequestOpenExplosionBox:InvokeServer()
        end)
end
if _G.Mode == "English" then
page2:Button("Rejoin",function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)

page2:Button("HopServer",function()
    repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
    local HttpService, TPService = game:GetService "HttpService", game:GetService "TeleportService";
    local OtherServers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" ..
        game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    function joinNew()
        if not isfile('servers.sss') then
            writefile('servers.sss', HttpService:JSONEncode({}))
        end
        local dontJoin = readfile('servers.sss')
        dontJoin = HttpService:JSONDecode(dontJoin)

        for Index, Server in next, OtherServers["data"] do
            if Server ~= game.JobId then
                local j = true
                for a, c in pairs(dontJoin) do
                    if c == Server.id then
                        j = false
                    end
                end
                if j then
                    table.insert(dontJoin, Server["id"])
                    writefile("servers.sss", HttpService:JSONEncode(dontJoin))
                    wait()
                    return Server['id']
                end
            end
        end
    end

    local server = joinNew()
    if not server then
        writefile("servers.sss", HttpService:JSONEncode({}))
        local server = joinNew()
        TPService:TeleportToPlaceInstance(game.PlaceId, server)
    else
        TPService:TeleportToPlaceInstance(game.PlaceId, server)
    end
end)

page2:Button("HoplittleServer",function()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    --[[
    local File = pcall(function()
        AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
    end)
    if not File then
        table.insert(AllIDs, actualHour)
        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
    end
    ]]
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                -- delfile("NotSameServers.json")
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        -- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end

    function Teleport()
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end

    Teleport()
end)
else
    _G.Mode = "Thai"
    page2:Button("Máy chủ",function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end)
    
    page2:Button("เปลี่ยนเซิฟเวอร์",function()
        repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
        local HttpService, TPService = game:GetService "HttpService", game:GetService "TeleportService";
        local OtherServers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" ..
            game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        function joinNew()
            if not isfile('servers.sss') then
                writefile('servers.sss', HttpService:JSONEncode({}))
            end
            local dontJoin = readfile('servers.sss')
            dontJoin = HttpService:JSONDecode(dontJoin)

            for Index, Server in next, OtherServers["data"] do
                if Server ~= game.JobId then
                    local j = true
                    for a, c in pairs(dontJoin) do
                        if c == Server.id then
                            j = false
                        end
                    end
                    if j then
                        table.insert(dontJoin, Server["id"])
                        writefile("servers.sss", HttpService:JSONEncode(dontJoin))
                        wait()
                        return Server['id']
                    end
                end
            end
        end

        local server = joinNew()
        if not server then
            writefile("servers.sss", HttpService:JSONEncode({}))
            local server = joinNew()
            TPService:TeleportToPlaceInstance(game.PlaceId, server)
        else
            TPService:TeleportToPlaceInstance(game.PlaceId, server)
        end
    end)
    
    page2:Button("เปลี่ยนเซิฟเวอร์ไปยังคนน้อย",function()
        local PlaceID = game.PlaceId
        local AllIDs = {}
        local foundAnything = ""
        local actualHour = os.date("!*t").hour
        local Deleted = false
        --[[
        local File = pcall(function()
            AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
        end)
        if not File then
            table.insert(AllIDs, actualHour)
            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
        end
        ]]
        function TPReturner()
            local Site;
            if foundAnything == "" then
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            else
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
            end
            local ID = ""
            if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                foundAnything = Site.nextPageCursor
            end
            local num = 0;
            for i,v in pairs(Site.data) do
                local Possible = true
                ID = tostring(v.id)
                if tonumber(v.maxPlayers) > tonumber(v.playing) then
                    for _,Existing in pairs(AllIDs) do
                        if num ~= 0 then
                            if ID == tostring(Existing) then
                                Possible = false
                            end
                        else
                            if tonumber(actualHour) ~= tonumber(Existing) then
                                local delFile = pcall(function()
                                    -- delfile("NotSameServers.json")
                                    AllIDs = {}
                                    table.insert(AllIDs, actualHour)
                                end)
                            end
                        end
                        num = num + 1
                    end
                    if Possible == true then
                        table.insert(AllIDs, ID)
                        wait()
                        pcall(function()
                            -- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                            wait()
                            game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                        end)
                        wait(4)
                    end
                end
            end
        end
    
        function Teleport()
            while wait() do
                pcall(function()
                    TPReturner()
                    if foundAnything ~= "" then
                        TPReturner()
                    end
                end)
            end
        end
    
        Teleport()
    end)
end
function two(gotoCFrame) --- Tween
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
    end)
    if (game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - gotoCFrame.Position).Magnitude <= 200 then
        pcall(function()
            tweenz:Cancel()
        end)
        game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.CFrame = gotoCFrame
    else
        local tween_s = game:service "TweenService"
        local info = TweenInfo.new(
            (game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - gotoCFrame.Position)
            .Magnitude /
            325, Enum.EasingStyle.Linear)
        tween, err = pcall(function()
            tweenz = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, { CFrame = gotoCFrame })
            tweenz:Play()
        end)
        if not tween then return err end
    end
    function _TweenCanCle()
        tweenz:Cancel()
    end
end
return VectorHub
