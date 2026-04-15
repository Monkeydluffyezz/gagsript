-- GagScript Hub X | Glow a Garden Edition
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Eskisini Temizle
if game.CoreGui:FindFirstChild("GagHubV2") then game.CoreGui.GagHubV2:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GagHubV2"
ScreenGui.Parent = game.CoreGui

-- ANA ÇERÇEVE
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -250, 0.5, -175)
Main.Size = UDim2.new(0, 500, 0, 350)
Main.ClipsDescendants = true
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Visible = false -- Animasyon için kapalı başlıyoruz

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 10)

-- ÜST NEON ÇİZGİ
local GlowLine = Instance.new("Frame", Main)
GlowLine.Size = UDim2.new(1, 0, 0, 2)
GlowLine.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
GlowLine.BorderSizePixel = 0

-- MENÜ AÇILIŞ ANİMASYONU
local function toggleMenu()
	if Main.Visible then
		Main:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true)
		task.wait(0.3)
		Main.Visible = false
	else
		Main.Visible = true
		Main.Size = UDim2.new(0, 0, 0, 0)
		Main:TweenSize(UDim2.new(0, 500, 0, 350), "Out", "Back", 0.4, true)
	end
end

-- K TUŞU İLE AÇ/KAPA
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.K then toggleMenu() end
end)

-- SOL PANEL (SEKMELER)
local SideBar = Instance.new("Frame", Main)
SideBar.Size = UDim2.new(0, 140, 1, -2)
SideBar.Position = UDim2.new(0, 0, 0, 2)
SideBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SideBar.BorderSizePixel = 0

local TabLayout = Instance.new("UIListLayout", SideBar)
TabLayout.Padding = UDim.new(0, 5)

-- İÇERİK ALANI
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -150, 1, -20)
Container.Position = UDim2.new(0, 145, 0, 10)
Container.BackgroundTransparency = 1

local function CreateToggle(parent, text, desc, callback)
	local ToggleFrame = Instance.new("Frame", parent)
	ToggleFrame.Size = UDim2.new(1, 0, 0, 50)
	ToggleFrame.BackgroundTransparency = 1
	
	local Label = Instance.new("TextLabel", ToggleFrame)
	Label.Text = text
	Label.Size = UDim2.new(0.8, 0, 0, 20)
	Label.TextColor3 = Color3.fromRGB(255, 80, 80)
	Label.Font = Enum.Font.GothamBold
	Label.BackgroundTransparency = 1
	Label.TextXAlignment = Enum.TextXAlignment.Left
	
	local Desc = Instance.new("TextLabel", ToggleFrame)
	Desc.Text = desc
	Desc.Position = UDim2.new(0, 0, 0, 20)
	Desc.Size = UDim2.new(0.8, 0, 0, 20)
	Desc.TextColor3 = Color3.fromRGB(150, 150, 150)
	Desc.TextSize = 10
	Desc.BackgroundTransparency = 1
	Desc.TextXAlignment = Enum.TextXAlignment.Left
	
	local Btn = Instance.new("TextButton", ToggleFrame)
	Btn.Size = UDim2.new(0, 40, 0, 20)
	Btn.Position = UDim2.new(0.9, -10, 0.2, 0)
	Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Btn.Text = ""
	local Corner = Instance.new("UICorner", Btn)
	Corner.CornerRadius = UDim.new(1, 0)
	
	local Circle = Instance.new("Frame", Btn)
	Circle.Size = UDim2.new(0, 16, 0, 16)
	Circle.Position = UDim2.new(0, 2, 0.5, -8)
	Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
	
	local toggled = false
	Btn.MouseButton1Click:Connect(function()
		toggled = not toggled
		local targetPos = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
		local targetCol = toggled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(50, 50, 50)
		
		TweenService:Create(Circle, TweenInfo.new(0.2), {Position = targetPos}):Play()
		TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = targetCol}):Play()
		callback(toggled)
	end)
end

-- SHOP SEKMESİ (Bütün Seedleri, Gearları ve Eggleri Al)
local ShopPage = Instance.new("ScrollingFrame", Container)
ShopPage.Size = UDim2.new(1, 0, 1, 0)
ShopPage.BackgroundTransparency = 1
ShopPage.Visible = true
Instance.new("UIListLayout", ShopPage).Padding = UDim.new(0, 10)

CreateToggle(ShopPage, "Buy All Seeds", "Shoptaki bütün tohumları otomatik alır.", function(state)
	_G.AutoSeeds = state
	while _G.AutoSeeds do
		-- Oyunun RemoteEvent ismi genelde 'PurchaseItem' olur
		local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Purchase", true) 
		if remote then
			-- Örnek döngü (Oyunun içindeki eşya isimlerine göre burası güncellenir)
			print("Tohumlar Alınıyor...") 
		end
		task.wait(1)
	end
end)

CreateToggle(ShopPage, "Buy All Gears", "Bütün ekipmanları satın alır.", function(state)
	-- Buraya Gear alma kodu gelecek
end)

CreateToggle(ShopPage, "Buy All Eggs", "Bütün yumurtaları otomatik açar/alır.", function(state)
	-- Buraya Egg alma kodu gelecek
end)

-- PLAYER SEKMESİ (En Alt)
local PlayerPage = Instance.new("ScrollingFrame", Container)
PlayerPage.Size = UDim2.new(1, 0, 1, 0)
PlayerPage.BackgroundTransparency = 1
PlayerPage.Visible = false
Instance.new("UIListLayout", PlayerPage).Padding = UDim.new(0, 10)

-- Speed Slider (Basit Versiyon)
CreateToggle(PlayerPage, "Super Speed", "Hızını 100 yapar.", function(state)
	LocalPlayer.Character.Humanoid.WalkSpeed = state and 100 or 16
end)

-- NoClip
local noclip = false
RunService.Stepped:Connect(function()
	if noclip and LocalPlayer.Character then
		for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide = false end
		end
	end
end)

CreateToggle(PlayerPage, "NoClip", "Duvarların içinden geçmeni sağlar.", function(state)
	noclip = state
end)

-- SEKMELER ARASI GEÇİŞ
-- (SideBar içine butonlar ekleyip Page.Visible ayarlarını buraya yapabilirsin)

toggleMenu() -- Başlat
