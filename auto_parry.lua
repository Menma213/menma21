-- auto_parry.lua
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local toolName = "Base Sword"
local tool = character:FindFirstChild(toolName) or character:WaitForChild(toolName, 10)

if not tool then
    warn("Tool not found!")
    return
end

local detectionRange = 10
local parryDelay = 0.1

local function detectBall()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Part") and obj.Name == "Ball" then
            return obj
        end
    end
    return nil
end

local function autoParry()
    if tool and tool:FindFirstChild("Parry") then
        tool.Parry:Invoke()
    end
end

while true do
    wait(parryDelay)
    local ball = detectBall()
    if ball and (ball.Position - character.HumanoidRootPart.Position).magnitude < detectionRange then
        autoParry()
    end
end
