-- Modern Roblox Script Hub UI (Speed Hub X Temalı)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ESKİ GAGSCRIPT UI'INI SİL (Varsa)
if PlayerGui:FindFirstChild("GagScriptHub") then
	PlayerGui:FindFirstChild("GagScriptHub"):Destroy()
end

-- ANA GUI OLUŞTURMA
local GagScriptHub = Instance.new("ScreenGui")
GagScriptHub.Name = "GagScriptHub"
GagScriptHub.Parent = PlayerGui
GagScriptHub.ResetOnSpawn = false
GagScriptHub.Enabled = true

-- Ana Çerçeve (MainFrame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = GagScriptHub
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Koyu Arka Plan
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.BorderSizePixel = 0

local UICorner_Main = Instance.new("UICorner")
UICorner_Main.CornerRadius = UDim.new(0, 8)
UICorner_Main.Parent = MainFrame

local UIGradient_Main = Instance.new("UIGradient")
UIGradient_Main.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
})
UIGradient_Main.Rotation = 45
UIGradient_Main.Parent = MainFrame

-- Neon Kenarlık (TopLine)
local TopLine = Instance.new("Frame")
TopLine.Name = "TopLine"
TopLine.Parent = MainFrame
TopLine.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- Kırmızı Ton
TopLine.BorderSizePixel = 0
TopLine.Position = UDim2.new(0, 0, 0, 0)
TopLine.Size = UDim2.new(1, 0, 0, 3)

local UIGradient_Line = Instance.new("UIGradient")
UIGradient_Line.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 60, 60)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 100)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 60, 60))
})
UIGradient_Line.Parent = TopLine

-- Başlık Çubuğu (TitleBar)
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BackgroundTransparency = 1
TitleBar.BorderSizePixel = 0
TitleBar.Position = UDim2.new(0, 0, 0, 3)
TitleBar.Size = UDim2.new(1, 0, 0, 35)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Gag Script Hub X | Version 1.0 | discord.gg/gagscript"
TitleLabel.TextColor3 = Color3.fromRGB(200, 60, 60)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Kapatma Butonu (CloseButton)
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.TextSize = 18

CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
end)

-- SOL MENÜ (TabsContainer)
local TabsContainer = Instance.new("Frame")
TabsContainer.Name = "TabsContainer"
TabsContainer.Parent = MainFrame
TabsContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TabsContainer.BorderSizePixel = 0
TabsContainer.Position = UDim2.new(0, 0, 0, 38)
TabsContainer.Size = UDim2.new(0, 150, 1, -38)

local UIListLayout_Tabs = Instance.new("UIListLayout")
UIListLayout_Tabs.Parent = TabsContainer
UIListLayout_Tabs.Padding = UDim.new(0, 2)
UIListLayout_Tabs.SortOrder = Enum.SortOrder.LayoutOrder

-- SAĞ İÇERİK (ContentContainer)
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
ContentContainer.BorderSizePixel = 0
ContentContainer.Position = UDim2.new(0, 150, 0, 38)
ContentContainer.Size = UDim2.new(1, -150, 1, -38)

-- SEKME FONKSİYONLARI VE İÇERİKLERİ
local ContentPanels = {}
local TabButtons = {}

local function createTabContent(name, isFirst)
	local Panel = Instance.new("ScrollingFrame")
	Panel.Name = name .. "Panel"
	Panel.Parent = ContentContainer
	Panel.BackgroundTransparency = 1
	Panel.BorderSizePixel = 0
	Panel.Size = UDim2.new(1, -10, 1, -10)
	Panel.Position = UDim2.new(0, 5, 0, 5)
	Panel.CanvasSize = UDim2.new(0, 0, 0, 500)
	Panel.ScrollBarThickness = 2
	Panel.ScrollBarImageColor3 = Color3.fromRGB(100, 30, 30)
	Panel.Visible = isFirst

	ContentPanels[name] = Panel

	local UIListLayout_Content = Instance.new("UIListLayout")
	UIListLayout_Content.Parent = Panel
	UIListLayout_Content.Padding = UDim.new(0, 5)
	UIListLayout_Content.SortOrder = Enum.SortOrder.LayoutOrder

	return Panel
end

local function selectTab(name)
	for tabName, panel in pairs(ContentPanels) do
		panel.Visible = (tabName == name)
	end
	for tabName, button in pairs(TabButtons) do
		if tabName == name then
			button.BackgroundColor3 = Color3.fromRGB(35, 20, 20)
			button.TextColor3 = Color3.fromRGB(255, 100, 100)
		else
			button.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			button.TextColor3 = Color3.fromRGB(180, 180, 180)
		end
	end
end

local function createTab(name, isFirst)
	local TabButton = Instance.new("TextButton")
	TabButton.Name = name .. "Tab"
	TabButton.Parent = TabsContainer
	TabButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	TabButton.BorderSizePixel = 0
	TabButton.Size = UDim2.new(1, 0, 0, 35)
	TabButton.Font = Enum.Font.Gotham
	TabButton.Text = "  " .. name -- Boşluk simge için
	TabButton.TextColor3 = Color3.fromRGB(180, 180, 180)
	TabButton.TextSize = 14
	TabButton.TextXAlignment = Enum.TextXAlignment.Left

	TabButtons[name] = TabButton
	local Panel = createTabContent(name, isFirst)

	TabButton.MouseButton1Click:Connect(function()
		selectTab(name)
	end)

	if isFirst then
		selectTab(name)
	end

	return TabButton, Panel
end

-- ÖRNEK SEKMELER OLUŞTURMA
-- 1. Home
local _, HomePanel = createTab("Home", true)
local HomeTitle = Instance.new("TextLabel")
HomeTitle.Parent = HomePanel
HomeTitle.Text = "Gag Script Hub Home"
HomeTitle.Font = Enum.Font.GothamBold
HomeTitle.TextSize = 18
HomeTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
HomeTitle.Size = UDim2.new(1, 0, 0, 30)
HomeTitle.BackgroundTransparency = 1

local DiscordFrame = Instance.new("Frame")
DiscordFrame.Parent = HomePanel
DiscordFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DiscordFrame.Size = UDim2.new(1, 0, 0, 60)
Instance.new("UICorner", DiscordFrame).CornerRadius = UDim.new(0, 6)

local DiscordLabel = Instance.new("TextLabel")
DiscordLabel.Parent = DiscordFrame
DiscordLabel.Text = "Join our Discord for updates!"
DiscordLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
DiscordLabel.TextSize = 14
DiscordLabel.Position = UDim2.new(0, 10, 0, 10)
DiscordLabel.Size = UDim2.new(1, -120, 0, 20)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.TextXAlignment = Enum.TextXAlignment.Left

local CopyDiscord = Instance.new("TextButton")
CopyDiscord.Parent = DiscordFrame
CopyDiscord.Text = "Copy Link"
CopyDiscord.Size = UDim2.new(0, 100, 0, 30)
CopyDiscord.Position = UDim2.new(1, -110, 0, 15)
CopyDiscord.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
CopyDiscord.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CopyDiscord)

CopyDiscord.MouseButton1Click:Connect(function()
	setclipboard("discord.gg/gagscript")
	CopyDiscord.Text = "Copied!"
	task.wait(2)
	CopyDiscord.Text = "Copy Link"
end)

-- Diğer Örnek Sekmeler
createTab("Main", false)
createTab("Automation", false)
createTab("Shop", false)
createTab("Misc", false)

-- MENÜ AÇMA/KAPAMA (K Tuşu ve Sağ Alt Buton)
local ToggleKey = Enum.KeyCode.K
local isMainFrameVisible = true

UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == ToggleKey then
		isMainFrameVisible = not isMainFrameVisible
		MainFrame.Visible = isMainFrameVisible
	end
end)

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = GagScriptHub
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Position = UDim2.new(1, -110, 1, -40)
ToggleButton.Size = UDim2.new(0, 100, 0, 30)
ToggleButton.Font = Enum.Font.GothamSemibold
ToggleButton.Text = "GagHub [K]"
ToggleButton.TextColor3 = Color3.fromRGB(200, 60, 60)
ToggleButton.TextSize = 14
ToggleButton.ZIndex = 10 -- Her zaman üstte

local UICorner_Toggle = Instance.new("UICorner")
UICorner_Toggle.CornerRadius = UDim.new(0, 6)
UICorner_Toggle.Parent = ToggleButton

local UIStroke_Toggle = Instance.new("UIStroke")
UIStroke_Toggle.Color = Color3.fromRGB(100, 30, 30)
UIStroke_Toggle.Thickness = 1
UIStroke_Toggle.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
	isMainFrameVisible = not isMainFrameVisible
	MainFrame.Visible = isMainFrameVisible
end)
