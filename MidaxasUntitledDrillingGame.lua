local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Midax HUB", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Farm"
})

Tab:AddToggle({
	Name = "Hand Drill Toggle",
	Default = false,
	Callback = function(state)
        HandDrill = state
        while HandDrill do task.wait()
            game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("OreService"):WaitForChild("RE"):WaitForChild("RequestRandomOre"):FireServer()
            end
	end    
})

local autosell = false

Tab:AddToggle({
	Name = "Sell Every 10 Seconds",
	Default = false,
	Callback = function(state)
        autosell = state  -- update the global variable

        if autosell then
            task.spawn(function()
                while autosell do
                    task.wait(10)

                    original = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-401, 92, 268)
                    task.wait(0.2)
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("OreService"):WaitForChild("RE"):WaitForChild("SellAll"):FireServer()

                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = original
                end
            end)
        end
	end    
})

local autocollectdrill = false

Tab:AddToggle({
	Name = "Auto Collect Drills (Every 15s)",
	Default = false,
	Callback = function(state)
        autocollectdrill = state
        local drillsFolder = workspace.Plots:GetChildren()[6]:WaitForChild("Drills")

        if autocollectdrill then
            task.spawn(function()
                while autocollectdrill do
                    task.wait(30)

                    local collectDrillRemote = game:GetService("ReplicatedStorage")
                        :WaitForChild("Packages"):WaitForChild("Knit")
                        :WaitForChild("Services"):WaitForChild("PlotService")
                        :WaitForChild("RE")
                        :WaitForChild("CollectDrill")

                    for _, drill in pairs(drillsFolder:GetChildren()) do
                        if drill:IsA("Model") then
                            collectDrillRemote:FireServer(drill)
                            task.wait(0.1)
                        end
                    end
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

Tab:AddButton({
	Name = "TP To Leaderboard",
	Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace:GetChildren()[16].LeaderboardFrame.CFrame
  	end    
})


