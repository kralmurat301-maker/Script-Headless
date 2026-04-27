--[[
    Made By Kzoit
    Toggle System Menu
]]

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local HeadlessBtn = Instance.new("TextButton")
local KorbloxBtn = Instance.new("TextButton")
local FullClearBtn = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")

-- GUI Ayarları
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "KzoitMenu"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -100)
MainFrame.Size = UDim2.new(0, 200, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "Made By Kzoit"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextSize = 18

UIListLayout.Parent = MainFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Buton Tasarım Fonksiyonu
local function styleButton(btn, text)
    btn.Parent = MainFrame
    btn.Size = UDim2.new(1, -10, 0, 50)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
end

styleButton(HeadlessBtn, "Sadece Headless")
styleButton(KorbloxBtn, "Sadece Korblox")
styleButton(FullClearBtn, "Headless + Saç/Eşya Kaldır")

-- FONKSİYONLAR
local plr = game:GetService("Players").LocalPlayer

-- 1. Sadece Headless 
local function makeHeadless(char)
    local h = char:FindFirstChild("Head")
    if h then
        h.Transparency = 1 [cite: 3]
        for _, v in ipairs(h:GetChildren()) do
            if v:IsA("Decal") then v.Transparency = 1 end
        end
    end
end

-- 2. Sadece Korblox [cite: 5, 6, 9]
local function makeKorblox(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    if hum.RigType == Enum.HumanoidRigType.R15 then
        local limbs = {
            {"RightLowerLeg", 902942093, true},
            {"RightUpperLeg", 902942096, false, 902843398},
            {"RightFoot", 902942089, true} [cite: 5]
        }
        for _, info in ipairs(limbs) do
            local p = char:FindFirstChild(info[1])
            if p then
                p.MeshId = "http://www.roblox.com/asset/?id=" .. info[2] [cite: 9]
                if info[3] then p.Transparency = 1 end [cite: 6]
            end
        end
    else -- R6 Uyumluluğu [cite: 7]
        local base = char:FindFirstChild("Right Leg")
        if base then
            base.Transparency = 1
            local shell = Instance.new("Part", char)
            shell.Name = "PhantomShell"
            shell.Size = Vector3.new(1, 2, 1)
            shell.CanCollide = false
            shell.Massless = true [cite: 8]
            local weld = Instance.new("WeldConstraint", shell)
            weld.Part0 = shell; weld.Part1 = base
            shell.CFrame = base.CFrame
            local mesh = Instance.new("SpecialMesh", shell)
            mesh.MeshId = "http://www.roblox.com/asset/?id=902942093" [cite: 9]
            mesh.Scale = Vector3.new(1.25, 1.25, 1.25)
        end
    end
end

-- 3. Full Headless (Saç ve Aksesuarlar Dahil)
local function fullClearHead(char)
    makeHeadless(char)
    for _, v in ipairs(char:GetChildren()) do
        if v:IsA("Accessory") and v:FindFirstChild("Handle") then
            local attachment = v.Handle:FindFirstChildOfClass("Attachment")
            if attachment and (attachment.Name:find("Hat") or attachment.Name:find("Hair") or attachment.Name:find("Face")) then
                v.Handle.Transparency = 1
            end
        end
    end
end

-- Buton Tıklamaları
HeadlessBtn.MouseButton1Click:Connect(function()
    if plr.Character then makeHeadless(plr.Character) end
end)

KorbloxBtn.MouseButton1Click:Connect(function()
    if plr.Character then makeKorblox(plr.Character) end
end)

FullClearBtn.MouseButton1Click:Connect(function()
    if plr.Character then fullClearHead(plr.Character) end
end)
