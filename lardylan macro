local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function EquipRevolver()
	local Character = LocalPlayer.Character
	if not Character then return nil end

	local Weapon = Character:FindFirstChild("Revolver") or Character:FindFirstChild("Gun")
	if Weapon then return Weapon end

	local Backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
	if Backpack then
		Weapon = Backpack:FindFirstChild("Revolver") or Backpack:FindFirstChild("Gun")
		if Weapon then
			Weapon.Parent = Character
			return Weapon
		end
	end
	return nil
end

local function GetClosestEnemy()
	local NearestPlayer = nil
	local ShortestDistance = math.huge

	for _, Player in pairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
			local TargetPart = Player.Character.HumanoidRootPart
			local Distance = (TargetPart.Position - Camera.CFrame.Position).Magnitude
			
			if Distance < ShortestDistance then
				ShortestDistance = Distance
				NearestPlayer = Player
			end
		end
	end
	return NearestPlayer
end

local LastShot = 0
local Cooldown = 0.15

RunService.RenderStepped:Connect(function()
	local Target = GetClosestEnemy()
	if Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
		local Weapon = EquipRevolver()
		if Weapon then
			local TargetPos = Target.Character.HumanoidRootPart.Position
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, TargetPos)

			if tick() - LastShot >= Cooldown then
				LastShot = tick()
				
				if Weapon:FindFirstChild("Shoot") then
					Weapon.Shoot:FireServer(TargetPos)
				elseif Weapon:FindFirstChild("OnShoot") then
					Weapon.OnShoot:FireServer(TargetPos)
				else
					Weapon:Activate()
				end
			end
		end
	end
end)
