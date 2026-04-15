local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

------------------------------------------------
-- GUI
------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "MainUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

------------------------------------------------
-- 📊 FPS COUNTER
------------------------------------------------
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 120, 0, 30)
fpsLabel.Position = UDim2.new(0, 10, 0, 10)
fpsLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
fpsLabel.BackgroundTransparency = 0.4
fpsLabel.TextColor3 = Color3.fromRGB(0,255,0)
fpsLabel.TextScaled = true
fpsLabel.Parent = gui

local frames = 0
local last = tick()

RunService.RenderStepped:Connect(function()
    frames += 1
    local now = tick()

    if now - last >= 1 then
        fpsLabel.Text = "FPS: " .. frames
        frames = 0
        last = now
    end
end)

------------------------------------------------
-- 🧠 SPEED SYSTEM
------------------------------------------------
local speed = 16

local function setSpeed(value)
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = value
end

player.CharacterAdded:Connect(function()
    task.wait(1)
    setSpeed(speed)
end)

------------------------------------------------
-- 📦 MENU SYSTEM
------------------------------------------------
local menus = {}

local function createMenu(name, color, pos)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(0, 320, 0, 220)
    frame.Position = pos
    frame.BackgroundColor3 = color
    frame.Visible = false
    frame.Parent = gui

    menus[name] = frame
    return frame
end

local mainMenu = createMenu("Main", Color3.fromRGB(40,40,40), UDim2.new(0.3,0,0.3,0))
local settingsMenu = createMenu("Settings", Color3.fromRGB(60,60,60), UDim2.new(0.3,0,0.3,0))
local visualMenu = createMenu("Visual", Color3.fromRGB(80,80,80), UDim2.new(0.3,0,0.3,0))

------------------------------------------------
-- ❌ CLOSE ALL
------------------------------------------------
local function closeAll()
    for _, v in pairs(menus) do
        v.Visible = false
    end
end

------------------------------------------------
-- 🎯 OPEN MENU (ANIMATED)
------------------------------------------------
local function openMenu(name)
    closeAll()

    local menu = menus[name]
    if not menu then return end

    menu.Visible = true
    menu.Size = UDim2.new(0, 0, 0, 0)

    TweenService:Create(menu,
        TweenInfo.new(0.25),
        {Size = UDim2.new(0, 320, 0, 220)}
    ):Play()
end

------------------------------------------------
-- 🔘 TAB BUTTONS
------------------------------------------------
local function makeButton(text, pos, targetMenu)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = pos
    btn.Text = text
    btn.Parent = gui

    btn.MouseButton1Click:Connect(function()
        openMenu(targetMenu)
    end)

    return btn
end

makeButton("Main", UDim2.new(0, 10, 0, 50), "Main")
makeButton("Settings", UDim2.new(0, 10, 0, 90), "Settings")
makeButton("Visual", UDim2.new(0, 10, 0, 130), "Visual")

------------------------------------------------
-- ⚙ SETTINGS UI (SPEED CONTROL)
------------------------------------------------
local settings = settingsMenu

local speedUp = Instance.new("TextButton")
speedUp.Size = UDim2.new(0, 140, 0, 30)
speedUp.Position = UDim2.new(0, 10, 0, 10)
speedUp.Text = "Speed +"
speedUp.Parent = settings

local speedDown = Instance.new("TextButton")
speedDown.Size = UDim2.new(0, 140, 0, 30)
speedDown.Position = UDim2.new(0, 10, 0, 50)
speedDown.Text = "Reset Speed"
speedDown.Parent = settings

speedUp.MouseButton1Click:Connect(function()
    speed += 5
    setSpeed(speed)
end)

speedDown.MouseButton1Click:Connect(function()
    speed = 16
    setSpeed(speed)
end)

------------------------------------------------
-- 🟢 START
------------------------------------------------
openMenu("Main")
setSpeed(speed)
