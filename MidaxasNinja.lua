local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Midaxas HUB", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://6031075939",
	PremiumOnly = false
})
local Section = Tab:AddSection({
	Name = "AutoFarm"
})

Tab:AddToggle({
    Name = "Auto Collect Coins",
    Default = false,
    Callback = function(state)
        mode4kill = state  -- set the mode based on toggle state
        while mode4kill do
            task.wait()
            for i, v in pairs(workspace.spawnedCoins.Valley:GetChildren()) do
                if v:IsA("Part") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                end
            end
        end
    end
})

Tab:AddToggle({
	Name = "Auto Train",
	Default = false,
	Callback = function(state)
		mode4kill = state
        while mode4kill do task.wait()
            local args = {
                "swingKatana"
            }
            game:GetService("Players").LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))
        end
            
	end    
})

local autofarm = false  -- define globally so it can be updated

Tab:AddToggle({
	Name = "Auto Farm Boss",
	Default = false,
	Callback = function(t)
		autofarm = t  -- update the global variable

		if autofarm then
			local player = game.Players.LocalPlayer
			local character = player.Character or player.CharacterAdded:Wait()
			local hrp = character:WaitForChild("HumanoidRootPart")
			local ninjaEvent = player:WaitForChild("ninjaEvent")

			task.spawn(function()
				while autofarm do
					task.wait()

					pcall(function()
						for _, boss in pairs(workspace.bossFolder:GetChildren()) do
							if boss:IsA("Model") and boss:FindFirstChild("HumanoidRootPart") and boss:FindFirstChild("Humanoid") then
								repeat
									-- Teleport to boss
									hrp.CFrame = boss.HumanoidRootPart.CFrame

									-- Auto attack
									ninjaEvent:FireServer("swingKatana")

									task.wait()
								until boss.Humanoid.Health <= 0 or not autofarm
							end
						end
					end)
				end
			end)
		end
	end    
})

local Tab = Window:MakeTab({
	Name = "Extra",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false

    
})

local Section = Tab:AddSection({
	Name = "Areas"
})

local areas_table = {}
if workspace:FindFirstChild("islandUnlockParts") then
    for i,v in pairs(workspace.islandUnlockParts:GetChildren()) do
        if string.match(v.Name,"Island") and not table.find(areas_table,v.Name) then
            table.insert(areas_table,v.Name)
        end
    end
end

Tab:AddDropdown({
	Name = "Islands",
	Default = "TpToIsland",
	Options = areas_table,
	Callback = function(t)
		areatoptop = t
	end    
})

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")

Tab:AddButton({
    Name = "Teleport To Area",
    Callback = function()
        print("Button pressed!")
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")

        for i, v in pairs(workspace.islandUnlockParts:GetChildren()) do
            print("Checking:", v.Name)
            if v.Name == areatoptop then
                print("Match found:", v.Name)
                local targetPart = v:FindFirstChildOfClass("Part")
                if targetPart then
                    print("Teleporting to:", targetPart.Name)
                    HumanoidRootPart.CFrame = targetPart.CFrame
                else
                    warn("No Part found in", v.Name)
                end
            end
        end
    end
})

Tab:AddButton({
	Name = "Unlock All Islands",
	Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        
        for i, v in pairs(workspace.islandUnlockParts:GetChildren()) do
            if v:IsA("BasePart") then
                hrp.CFrame = v.CFrame
                task.wait(0.05)
            end
        end
  	end    
})

Tab:AddButton({
	Name = "Teleport To Best Sell Area",
	Callback = function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(87, 91246, 129)
  	end    
})
