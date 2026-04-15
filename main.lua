-- GagScript Hub X | Glow a Garden Edition
-- Keybind: K

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Eskisini Temizle
if game.CoreGui:FindFirstChild("GagHubV2") then game.CoreGui.GagHubV2:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GagHubV2"
ScreenGui.Parent = game.CoreGui

-- ANA ÇERÇEVE
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 520, 0, 380)
Main.ClipsDescendants = true
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Visible = false

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 12)

-- ÜST ŞERİT (Neon Kırmızı)
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 3)
TopBar.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
TopBar.BorderSizePixel = 0

-- SEKMELER ARASI GEÇİŞ MANTIĞI
local Pages = {}
local TabButtons = {}

local function ShowPage(name)
    for i, v in pairs(Pages) do v.Visible = (i == name) end
    for i, v in pairs(TabButtons) do 
        v.TextColor3 = (i == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
        v.BackgroundColor3 = (i == name) and Color3.fromRGB(35, 35, 35) or Color3.fromRGB(20, 20, 20)
    end
end

-- SOL PANEL
local SideBar = Instance.new("Frame", Main)
SideBar.Size = UDim2.new(0, 130, 1, -3)
SideBar.Position = UDim2.new(0, 0, 0, 3)
SideBar.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
SideBar.BorderSizePixel = 0

local TabLayout = Instance.new("UIListLayout", SideBar)
TabLayout.Padding = UDim.new(0, 2)

-- İÇERİK KONTEYNERI
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -140, 1, -20)
Container.Position = UDim2.new(0, 135, 0, 10)
Container.BackgroundTransparency = 1

local function CreateTab(name)
    local Btn = Instance.new("TextButton", SideBar)
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Btn.BorderSizePixel = 0
    Btn.Text = name
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    Btn.TextSize = 14
    
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)
    
    Pages[name] = Page
    TabButtons[name] = Btn
    
    Btn.MouseButton1Click:Connect(function() ShowPage(name) end)
end

local function CreateToggle(parent, text, desc, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, -10, 0, 55)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)
    
    local Title = Instance.new("TextLabel", Frame)
    Title.Text = text
    Title.Size = UDim2.new(0.7, 0, 0, 25)
    Title.Position = UDim2.new(0, 10, 0, 5)
    Title.TextColor3 = Color3.fromRGB(255, 60, 60)
    Title.Font = Enum.Font.GothamBold
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = "Left"
    
    local Info = Instance.new("TextLabel", Frame)
    Info.Text = desc
    Info.Size = UDim2.new(0.7, 0, 0, 20)
    Info.Position = UDim2.new(0, 10, 0, 25)
    Info.TextColor3 = Color3.fromRGB(180, 180, 180)
    Info.TextSize = 11
    Info.BackgroundTransparency = 1
    Info.TextXAlignment = "Left"
    
    local Swch = Instance.new("TextButton", Frame)
    Swch.Size = UDim2.new(0, 45, 0, 22)
    Swch.Position = UDim2.new(1, -55, 0.5, -11)
    Swch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Swch.Text = ""
    Instance.new("UICorner", Swch).CornerRadius = UDim.new(1, 0)
    
    local Circ = Instance.new("Frame", Swch)
    Circ.Size = UDim2.new(0, 18, 0, 18)
    Circ.Position = UDim2.new(0, 2, 0.5, -9)
    Circ.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Circ).CornerRadius = UDim.new(1, 0)
    
    local active = false
    Swch.MouseButton1Click:Connect(function()
        active = not active
        TweenService:Create(Circ, TweenInfo.new(0.2), {Position = active and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}):Play()
        TweenService:Create(Swch, TweenInfo.new(0.2), {BackgroundColor3 = active and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 50, 50)}):Play()
        callback(active)
    end)
end

-- SEKMELERİ OLUŞTUR
CreateTab("Shop")
CreateTab("Player")

-- SHOP ÖZELLİKLERİ
CreateToggle(Pages.Shop, "Instant Buy Seeds", "Bütün tohumları saniyeler içinde alır.", function(state)
    _G.BuySeeds = state
    while _G.BuySeeds do
        -- Glow a Garden Seed Remotelarını tetikler
        local seeds = {"Carrot", "Tomato", "GlowingBerry", "GoldenBean"} -- Örnekler
        for _, seed in pairs(seeds) do
            ReplicatedStorage.Events.Shop.BuyItem:FireServer(seed, 1)
        end
        task.wait(0.5)
    end
end)

CreateToggle(Pages.Shop, "Auto Gear Buyer", "Bütün ekipmanları envantere çeker.", function(state)
    _G.BuyGears = state
    -- Gear Remote logic buraya
end)

CreateToggle(Pages.Shop, "Infinite Eggs", "Yumurtaları durmadan açar.", function(state)
    _G.BuyEggs = state
end)

-- PLAYER ÖZELLİKLERİ
CreateToggle(Pages.Player, "Gag Speed", "Karakteri uçurur.", function(state)
    LocalPlayer.Character.Humanoid.WalkSpeed = state and 120 or 16
end)

local noclip = false
RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

CreateToggle(Pages.Player, "NoClip", "Duvarlar senin için yok olur.", function(state)
    noclip = state
end)

-- AÇILIŞ ANİMASYONU VE KONTROL
local function toggle()
    if Main.Visible then
        Main:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 0.3, true, function() Main.Visible = false end)
    else
        Main.Visible = true
        Main.Size = UDim2.new(0, 0, 0, 0)
        Main:TweenSize(UDim2.new(0, 520, 0, 380), "Out", "Back", 0.4, true)
    end
end

UserInputService.InputBegan:Connect(function(i) if i.KeyCode == Enum.KeyCode.K then toggle() end end)
ShowPage("Shop")
toggle()
