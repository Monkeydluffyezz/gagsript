-- GagScript Hub X | Glow a Garden - LURAPH DECODED VERSION
-- Keybind: K

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- GİZLİ REMOTE YOLLARI (Sızıntıdan Alındı)
local Remotes = {}
task.spawn(function()
    Remotes.Collect = ReplicatedStorage:FindFirstChild("Collect", true)
    Remotes.Water = ReplicatedStorage:FindFirstChild("Water_RE", true)
    Remotes.Crate = ReplicatedStorage:FindFirstChild("CosmeticCrateService", true)
    Remotes.ActivePet = ReplicatedStorage:FindFirstChild("ActivePetService", true)
    Remotes.Mutation = ReplicatedStorage:FindFirstChild("PetMutationMachineService_RE", true)
    Remotes.Cooking = ReplicatedStorage:FindFirstChild("CookingPotService_RE", true)
end)

-- Eskisini Temizle
if game.CoreGui:FindFirstChild("GagHubV3") then game.CoreGui.GagHubV3:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GagHubV3"
ScreenGui.Parent = game.CoreGui

-- ANA ÇERÇEVE
local Main = Instance.new("Frame", ScreenGui)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Main.Position = UDim2.new(0.5, -260, 0.5, -190)
Main.Size = UDim2.new(0, 520, 0, 380)
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- ÜST ŞERİT (Neon Kırmızı)
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 3)
TopBar.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
TopBar.BorderSizePixel = 0

-- SEKMELER ARASI GEÇİŞ
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

-- SEKMELER
CreateTab("Farming")
CreateTab("Pets")
CreateTab("Machines")
CreateTab("Player")

-- FARMING (Tarla/Toplama)
CreateToggle(Pages.Farming, "Auto Collect Plants", "Bütün büyümüş bitkileri anında toplar.", function(state)
    _G.AutoCollect = state
    task.spawn(function()
        while _G.AutoCollect do
            local plants = workspace:FindFirstChild("Plants_Physical")
            if plants and Remotes.Collect then
                for _, plant in pairs(plants:GetChildren()) do
                    if plant:IsA("Model") then
                        pcall(function() Remotes.Collect:FireServer({plant}) end)
                    end
                end
            end
            task.wait(0.2)
        end
    end)
end)

CreateToggle(Pages.Farming, "Auto Water", "Kuruyan bitkileri otomatik sular.", function(state)
    _G.AutoWater = state
    task.spawn(function()
        while _G.AutoWater do
            local plants = workspace:FindFirstChild("Plants_Physical")
            if plants and Remotes.Water then
                for _, plant in pairs(plants:GetChildren()) do
                    if plant:IsA("Model") then
                        pcall(function() Remotes.Water:FireServer(plant:GetPivot().Position) end)
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

-- PETS (Evcil Hayvanlar)
CreateToggle(Pages.Pets, "Auto Feed Pets", "Aç kalan petleri otomatik besler.", function(state)
    _G.AutoFeed = state
    task.spawn(function()
        while _G.AutoFeed do
            local pets = workspace:FindFirstChild("PetsPhysical")
            if pets and Remotes.ActivePet then
                for _, pet in pairs(pets:GetChildren()) do
                    if pet:GetAttribute("OWNER") == LocalPlayer.Name then
                        local uuid = pet:GetAttribute("UUID")
                        if uuid then
                            pcall(function() Remotes.ActivePet:FireServer("Feed", uuid) end)
                        end
                    end
                end
            end
            task.wait(2)
        end
    end)
end)

CreateToggle(Pages.Pets, "Auto Mutate", "Petleri otomatik mutasyon makinesine atar.", function(state)
    _G.AutoMutate = state
    task.spawn(function()
        while _G.AutoMutate do
            if Remotes.Mutation then
                pcall(function() Remotes.Mutation:FireServer("Submit HeldPet") end)
                task.wait(0.5)
                pcall(function() Remotes.Mutation:FireServer("StartMachine") end)
                task.wait(0.5)
                pcall(function() Remotes.Mutation:FireServer("ClaimMutatedPet") end)
            end
            task.wait(1)
        end
    end)
end)

-- MACHINES (Kutular ve Aşçılık)
CreateToggle(Pages.Machines, "Auto Open Crates", "Envanterdeki kutuları saniyesinde açar.", function(state)
    _G.AutoCrate = state
    task.spawn(function()
        while _G.AutoCrate do
            local objects = workspace:FindFirstChild("Objects_Physical")
            if objects and Remotes.Crate then
                for _, obj in pairs(objects:GetChildren()) do
                    if obj:GetAttribute("OWNER") == LocalPlayer.Name and obj:GetAttribute("CrateType") then
                        if obj:GetAttribute("TimeToOpen") <= 0 then
                            pcall(function() Remotes.Crate:FireServer("OpenCrate", obj) end)
                        end
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

CreateToggle(Pages.Machines, "Auto Cook Best", "Aşçılık potunda en iyi yemeği otomatik yapar.", function(state)
    _G.AutoCook = state
    task.spawn(function()
        while _G.AutoCook do
            if Remotes.Cooking then
                local objects = workspace:FindFirstChild("Cosmetic_Physical")
                if objects then
                    for _, obj in pairs(objects:GetChildren()) do
                        pcall(function() Remotes.Cooking:FireServer("CookBest", obj) end)
                    end
                end
            end
            task.wait(2)
        end
    end)
end)

-- PLAYER
CreateToggle(Pages.Player, "Gag Speed", "Yürüme hızını 100 yapar.", function(state)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = state and 100 or 16
    end
end)

-- Menüyü Göster/Gizle Tuşu (K)
local visible = true
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.K then
        visible = not visible
        Main.Visible = visible
    end
end)

ShowPage("Farming")
