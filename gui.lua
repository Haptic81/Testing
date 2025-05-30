local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "SharpUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 420, 0, 260)
frame.Position = UDim2.new(0.5, -210, 0.5, -130)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "SHARP UI"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local notifHolder = Instance.new("Frame", frame)
notifHolder.Size = UDim2.new(0, 220, 0, 80)
notifHolder.Position = UDim2.new(1, -230, 1, -90)
notifHolder.BackgroundTransparency = 1
notifHolder.ClipsDescendants = true

local notification = Instance.new("Frame", notifHolder)
notification.Size = UDim2.new(1, 0, 1, 0)
notification.Position = UDim2.new(0, 0, 1, 80)
notification.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
notification.BorderSizePixel = 0
notification.Visible = false

local notifText = Instance.new("TextLabel", notification)
notifText.Size = UDim2.new(1, -10, 0, 40)
notifText.Position = UDim2.new(0, 5, 0, 5)
notifText.Text = "Update available!"
notifText.TextColor3 = Color3.new(1, 1, 1)
notifText.Font = Enum.Font.Gotham
notifText.TextScaled = true
notifText.BackgroundTransparency = 1
notifText.TextXAlignment = Enum.TextXAlignment.Left

local updateButton = Instance.new("TextButton", notification)
updateButton.Size = UDim2.new(0, 200, 0, 30)
updateButton.Position = UDim2.new(0.5, -100, 1, -35)
updateButton.Text = "Update"
updateButton.Font = Enum.Font.GothamBold
updateButton.TextColor3 = Color3.new(1, 1, 1)
updateButton.TextScaled = true
updateButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
updateButton.BorderSizePixel = 0

updateButton.MouseEnter:Connect(function()
	updateButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
end)
updateButton.MouseLeave:Connect(function()
	updateButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

updateButton.MouseButton1Click:Connect(function()
	gui:Destroy()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Haptic81/Testing/refs/heads/main/gui.lua"))()
end)

local function slideInNotification()
	notification.Visible = true
	notification.BackgroundTransparency = 1
	for _, v in pairs(notification:GetDescendants()) do
		if v:IsA("TextLabel") or v:IsA("TextButton") then
			v.TextTransparency = 1
		end
	end
	notification.Position = UDim2.new(0, 0, 1, 80)
	TweenService:Create(notification, TweenInfo.new(0.4), {
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 0
	}):Play()
	for _, v in pairs(notification:GetDescendants()) do
		if v:IsA("TextLabel") or v:IsA("TextButton") then
			TweenService:Create(v, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
		end
	end
end

local currentVersion = "1.0"
local versionURL = "https://raw.githubusercontent.com/Haptic81/Testing/refs/heads/main/version.txt"
local function checkForUpdate()
	local success, res = pcall(function()
		return game:HttpGet(versionURL)
	end)
	if success and res and res ~= currentVersion then
		slideInNotification()
	end
end

checkForUpdate()
while wait(10) do
	checkForUpdate()
end
