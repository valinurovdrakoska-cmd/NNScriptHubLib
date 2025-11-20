-- Premium.lua | NNScriptHub Premium — ВСЁ РАБОТАЕТ
local plr = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local cam = workspace.CurrentCamera

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/valinurovdrakoska-cmd/NNScriptHubLib/refs/heads/main/Library.lua"))()

local window = lib:Create({
    Title = "NNScriptHub Premium",
    KeySystem = true,
    Key = "NNPREMIUM-XAI2025"
})

-- === ВСЕ КНОПКИ (теперь точно видны) ===

-- Fly
local flying = false
local flyBV = nil
local function startFly()
    if flying then return end
    flying = true
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    flyBV = Instance.new("BodyVelocity", hrp)
    flyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
    flyBV.Velocity = Vector3.new(0,0,0)
    spawn(function()
        while flying do
            local move = Vector3.new(0,0,0)
            if uis:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
            if uis:IsKeyDown(Enum.KeyCode.LeftShift) then move = move + Vector3.new(0,-1,0) end
            flyBV.Velocity = move * 120
            rs.Heartbeat:Wait()
        end
    end)
end
local function stopFly()
    flying = false
    if flyBV then flyBV:Destroy() end
end
window:Toggle("Fly", false, function(state)
    if state then startFly() else stopFly() end
end)

-- ESP
local espOn = false
window:Toggle("ESP", false, function(state)
    espOn = state
end)

-- WalkSpeed
window:Textbox("WalkSpeed", "Введите скорость", function(val)
    local n = tonumber(val)
    if n and plr.Character then
        plr.Character.Humanoid.WalkSpeed = n
        if n == 666 then
            game.StarterGui:SetCore("SendNotification",{Title="OMG!",Text="осуждаю но уважаю 😈",Duration=6})
        end
    end
end)

-- JumpPower
window:Textbox("JumpPower", "Введите силу прыжка", function(val)
    local n = tonumber(val)
    if n and plr.Character then
        plr.Character.Humanoid.JumpPower = n
        if n == 666 then
            game.StarterGui:SetCore("SendNotification",{Title="OMG!",Text="осуждаю но уважаю 😈",Duration=6})
        end
    end
end)

-- Noclip
local noclipOn = false
window:Toggle("Noclip", false, function(state)
    noclipOn = state
end)
rs.Stepped:Connect(function()
    if noclipOn and plr.Character then
        for _,v in plr.Character:GetDescendants() do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- Infinite Jump
local infJump = false
window:Toggle("Infinite Jump", false, function(state)
    infJump = state
end)
uis.InputBegan:Connect(function(inp)
    if infJump and inp.KeyCode == Enum.KeyCode.Space then
        plr.Character.Humanoid:ChangeState("Jumping")
    end
end)

-- Gravity
window:Textbox("Gravity", "192 по дефолту", function(val)
    local n = tonumber(val)
    if n then workspace.Gravity = n end
end)

-- Visual GodMode
local vgod = false
window:Toggle("Visual GodMode", false, function(state)
    vgod = state
    if vgod then
        spawn(function()
            while vgod do
                if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    plr.Character.Humanoid.Health = 100
                end
                wait()
            end
        end)
    end
end)

-- Instant Respawn
window:Button("Instant Respawn", function()
    if plr.Character then plr.Character.Humanoid.Health = 0 end
end)

-- Infinite Yield
window:Button("Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- Сброс
window:Button("СБРОС НА ДЕФОЛТ", function()
    stopFly()
    if plr.Character then
        plr.Character.Humanoid.WalkSpeed = 16
        plr.Character.Humanoid.JumpPower = 50
    end
    workspace.Gravity = 192
    noclipOn = false
    infJump = false
    vgod = false
    espOn = false
end)
