-- Plane Crazy Earthbending Script
-- This script creates a GUI for earthbending options and places a sphere of blocks around the player.

local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local placeEvent = replicatedStorage:WaitForChild("Place")

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 2
mainFrame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Earthbending Options"
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Parent = mainFrame

local radiusLabel = Instance.new("TextLabel")
radiusLabel.Text = "Radius:"
radiusLabel.Size = UDim2.new(0.3, 0, 0, 30)
radiusLabel.Position = UDim2.new(0, 10, 0, 40)
radiusLabel.BackgroundTransparency = 1
radiusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
radiusLabel.Parent = mainFrame

local radiusInput = Instance.new("TextBox")
radiusInput.Text = "5"
radiusInput.Size = UDim2.new(0.6, 0, 0, 30)
radiusInput.Position = UDim2.new(0.35, 0, 0, 40)
radiusInput.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
radiusInput.TextColor3 = Color3.fromRGB(255, 255, 255)
radiusInput.Parent = mainFrame

local blockTypeLabel = Instance.new("TextLabel")
blockTypeLabel.Text = "Block Type:"
blockTypeLabel.Size = UDim2.new(0.3, 0, 0, 30)
blockTypeLabel.Position = UDim2.new(0, 10, 0, 80)
blockTypeLabel.BackgroundTransparency = 1
blockTypeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
blockTypeLabel.Parent = mainFrame

local blockTypeInput = Instance.new("TextBox")
blockTypeInput.Text = "Block"
blockTypeInput.Size = UDim2.new(0.6, 0, 0, 30)
blockTypeInput.Position = UDim2.new(0.35, 0, 0, 80)
blockTypeInput.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
blockTypeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
blockTypeInput.Parent = mainFrame

local activateButton = Instance.new("TextButton")
activateButton.Text = "Activate Earthbending"
activateButton.Size = UDim2.new(0.8, 0, 0, 40)
activateButton.Position = UDim2.new(0.1, 0, 0, 130)
activateButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
activateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
activateButton.Parent = mainFrame

-- Function to place sphere
local function placeSphere(center, radius, blockType)
    local density = 1  -- studs per block
    for theta = 0, math.pi, math.pi / (radius * 2) do
        for phi = 0, 2 * math.pi, math.pi / (radius * 2) do
            local x = center.X + radius * math.sin(theta) * math.cos(phi)
            local y = center.Y + radius * math.cos(theta)
            local z = center.Z + radius * math.sin(theta) * math.sin(phi)
            local pos = Vector3.new(math.floor(x / density) * density, math.floor(y / density) * density, math.floor(z / density) * density)
            placeEvent:FireServer(blockType, pos, CFrame.new(pos))
        end
    end
end

-- Button click
activateButton.MouseButton1Click:Connect(function()
    local radius = tonumber(radiusInput.Text) or 5
    local blockType = blockTypeInput.Text or "Block"
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local center = character.HumanoidRootPart.Position
        placeSphere(center, radius, blockType)
    end
end)