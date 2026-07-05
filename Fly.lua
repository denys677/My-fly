-- Удобный Fly скрипт для Delta (мобильный/ПК)
local LP = game:GetService("Players").LocalPlayer
local Mouse = LP:GetMouse()

local Flying = false
local FlySpeed = 50 -- Можешь изменить скорость тут

-- Создаем маленькую кнопку на экране, чтобы было удобно включать/выключать на телефоне
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Position = UDim2.new(0.1, 0, 0.2, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "Fly: OFF"
ToggleButton.TextSize = 18
ToggleButton.Active = true
ToggleButton.Draggable = true -- Можно перетаскивать кнопку по экрану

local TFrame = Instance.new("Frame")
TFrame.Parent = LP.Character:WaitForChild("HumanoidRootPart")

ToggleButton.MouseButton1Click:Connect(function()
    Flying = not Flying
    if Flying then
        ToggleButton.Text = "Fly: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        
        local T = LP.Character.HumanoidRootPart
        local BG = Instance.new("BodyGyro", T)
        local BV = Instance.new("BodyVelocity", T)
        
        BG.P = 9e4
        BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        BG.cframe = T.CFrame
        
        BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
        BV.velocity = Vector3.new(0, 0.1, 0)
        
        spawn(function()
            repeat wait()
                LP.Character.Humanoid.PlatformStand = true
                -- Направление полета зависит от того, куда смотрит камера
                local Cam = workspace.CurrentCamera.CFrame
                BV.velocity = Cam.LookVector * FlySpeed
                BG.cframe = Cam
            until not Flying
            
            BG:Destroy()
            BV:Destroy()
            LP.Character.Humanoid.PlatformStand = false
            ToggleButton.Text = "Fly: OFF"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end)
    else
        ToggleButton.Text = "Fly: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end
end)
