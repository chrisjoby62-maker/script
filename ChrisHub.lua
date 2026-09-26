--// CHRIS HUB
--// Put this ONE LocalScript inside StarterPlayer > StarterPlayerScripts
--// Designed for your own Roblox Studio game

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

--==================================================
-- VARIABLES
--==================================================

local Flying = false
local InfJump = false
local Speed = 16
local JumpPower = 50

local FlySpeed = 60
local FlyConnection
local JumpConnection

local Character
local Humanoid
local Root

local function SetupCharacter(char)
	Character = char
	Humanoid = char:WaitForChild("Humanoid")
	Root = char:WaitForChild("HumanoidRootPart")

	Humanoid.WalkSpeed = Speed
	Humanoid.UseJumpPower = true
	Humanoid.JumpPower = JumpPower
end

if Player.Character then
	SetupCharacter(Player.Character)
end

Player.CharacterAdded:Connect(function(char)
	SetupCharacter(char)

	if Flying then
		task.wait(1)
		Flying = false
	end
end)

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "ChrisHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = Player:WaitForChild("PlayerGui")

-- Main window
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 430, 0, 330)
Main.Position = UDim2.new(0.5, -215, 0.5, -165)
Main.BackgroundColor3 = Color3.fromRGB(18,18,22)
Main.BorderSizePixel = 0
Main.Parent = Gui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0,10)
Corner.Parent = Main

-- Top bar
local Top = Instance.new("Frame")
Top.Size = UDim2.new(1,0,0,48)
Top.BackgroundColor3 = Color3.fromRGB(25,25,30)
Top.BorderSizePixel = 0
Top.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0,10)
TopCorner.Parent = Top

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-100,1,0)
Title.Position = UDim2.new(0,15,0,0)
Title.BackgroundTransparency = 1
Title.Text = "CHRIS HUB"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

-- Close
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,40,0,40)
Close.Position = UDim2.new(1,-45,0,4)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(255,80,80)
Close.TextSize = 28
Close.Font = Enum.Font.GothamBold
Close.Parent = Top

--==================================================
-- DRAGGING
--==================================================

local Dragging = false
local DragStart
local StartPos

Top.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		Dragging = true
		DragStart = input.Position
		StartPos = Main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				Dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if Dragging and
		(input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then

		local Delta = input.Position - DragStart

		Main.Position = UDim2.new(
			StartPos.X.Scale,
			StartPos.X.Offset + Delta.X,
			StartPos.Y.Scale,
			StartPos.Y.Offset + Delta.Y
		)
	end
end)

--==================================================
-- MINIMIZE / REOPEN
--==================================================

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0,130,0,42)
OpenButton.Position = UDim2.new(0,15,0.5,-21)
OpenButton.BackgroundColor3 = Color3.fromRGB(25,25,30)
OpenButton.Text = "CHRIS HUB"
OpenButton.TextColor3 = Color3.fromRGB(255,255,255)
OpenButton.TextSize = 16
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenButton.Parent = Gui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0,9)
OpenCorner.Parent = OpenButton

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
	OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
	Main.Visible = true
	OpenButton.Visible = false
end)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,115,1,-48)
Sidebar.Position = UDim2.new(0,0,0,48)
Sidebar.BackgroundColor3 = Color3.fromRGB(22,22,27)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local function SidebarButton(Text, Position)
	local B = Instance.new("TextButton")
	B.Size = UDim2.new(1,-16,0,42)
	B.Position = UDim2.new(0,8,0,Position)
	B.BackgroundColor3 = Color3.fromRGB(30,30,36)
	B.Text = Text
	B.TextColor3 = Color3.fromRGB(220,220,220)
	B.TextSize = 14
	B.Font = Enum.Font.GothamMedium
	B.Parent = Sidebar

	local C = Instance.new("UICorner")
	C.CornerRadius = UDim.new(0,7)
	C.Parent = B

	return B
end

local MovementButton = SidebarButton("Movement",15)
local TrollButton = SidebarButton("Troll",65)

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1,-125,1,-58)
Content.Position = UDim2.new(0,120,0,53)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 4
Content.CanvasSize = UDim2.new(0,0,0,600)
Content.Parent = Main

local MovementPage = Instance.new("Frame")
MovementPage.Size = UDim2.new(1,-10,0,550)
MovementPage.BackgroundTransparency = 1
MovementPage.Parent = Content

local TrollPage = Instance.new("Frame")
TrollPage.Size = UDim2.new(1,-10,0,550)
TrollPage.BackgroundTransparency = 1
TrollPage.Visible = false
TrollPage.Parent = Content

--==================================================
-- BUTTON CREATOR
--==================================================

local function Button(parent, text, y)
	local B = Instance.new("TextButton")
	B.Size = UDim2.new(1,-10,0,42)
	B.Position = UDim2.new(0,5,0,y)
	B.BackgroundColor3 = Color3.fromRGB(30,30,36)
	B.Text = text
	B.TextColor3 = Color3.fromRGB(235,235,235)
	B.TextSize = 14
	B.Font = Enum.Font.GothamMedium
	B.Parent = parent

	local C = Instance.new("UICorner")
	C.CornerRadius = UDim.new(0,7)
	C.Parent = B

	return B
end

local function Label(parent,text,y)
	local L = Instance.new("TextLabel")
	L.Size = UDim2.new(1,-10,0,25)
	L.Position = UDim2.new(0,5,0,y)
	L.BackgroundTransparency = 1
	L.Text = text
	L.TextColor3 = Color3.fromRGB(150,150,160)
	L.TextSize = 13
	L.Font = Enum.Font.Gotham
	L.TextXAlignment = Enum.TextXAlignment.Left
	L.Parent = parent
	return L
end

--==================================================
-- MOVEMENT
--==================================================

Label(MovementPage,"MOVEMENT",5)

local FlyButton = Button(MovementPage,"Fly : OFF",35)
local JumpButton = Button(MovementPage,"Infinite Jump : OFF",85)

local SpeedButton = Button(MovementPage,"Speed : 16",135)
local JumpPowerButton = Button(MovementPage,"Jump Power : 50",185)

--==================================================
-- FLY
--==================================================

local function StopFly()
	Flying = false

	if FlyConnection then
		FlyConnection:Disconnect()
		FlyConnection = nil
	end

	if Humanoid then
		Humanoid.PlatformStand = false
	end

	FlyButton.Text = "Fly : OFF"
end

local function StartFly()
	if not Character or not Root then return end

	Flying = true
	FlyButton.Text = "Fly : ON"

	FlyConnection = RunService.RenderStepped:Connect(function()
		if not Flying or not Character or not Root then
			return
		end

		local Camera = workspace.CurrentCamera
		local Direction = Vector3.zero

		if UIS:IsKeyDown(Enum.KeyCode.W) then
			Direction += Camera.CFrame.LookVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.S) then
			Direction -= Camera.CFrame.LookVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.A) then
			Direction -= Camera.CFrame.RightVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.D) then
			Direction += Camera.CFrame.RightVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.Space) then
			Direction += Vector3.new(0,1,0)
		end

		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
			Direction -= Vector3.new(0,1,0)
		end

		if Direction.Magnitude > 0 then
			Direction = Direction.Unit
		end

		Root.AssemblyLinearVelocity = Direction * FlySpeed
	end)
end

FlyButton.MouseButton1Click:Connect(function()
	if Flying then
		StopFly()
	else
		StartFly()
	end
end)

--==================================================
-- INFINITE JUMP
--==================================================

JumpConnection = UIS.JumpRequest:Connect(function()
	if InfJump and Humanoid then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

JumpButton.MouseButton1Click:Connect(function()
	InfJump = not InfJump

	if InfJump then
		JumpButton.Text = "Infinite Jump : ON"
	else
		JumpButton.Text = "Infinite Jump : OFF"
	end
end)

--==================================================
-- SPEED
--==================================================

SpeedButton.MouseButton1Click:Connect(function()
	Speed += 10

	if Speed > 100 then
		Speed = 16
	end

	SpeedButton.Text = "Speed : "..Speed

	if Humanoid then
		Humanoid.WalkSpeed = Speed
	end
end)

--==================================================
-- JUMP POWER
--==================================================

JumpPowerButton.MouseButton1Click:Connect(function()
	JumpPower += 25

	if JumpPower > 200 then
		JumpPower = 50
	end

	JumpPowerButton.Text = "Jump Power : "..JumpPower

	if Humanoid then
		Humanoid.JumpPower = JumpPower
	end
end)

--==================================================
-- TROLL SECTION
--==================================================

Label(TrollPage,"TROLL / FUN",5)

local SpinButton = Button(TrollPage,"Spin : OFF",35)
local BigHeadButton = Button(TrollPage,"Big Head",85)
local SmallButton = Button(TrollPage,"Small Character",135)
local RainbowButton = Button(TrollPage,"Rainbow Character",185)
local ResetButton = Button(TrollPage,"Reset Character",235)

--==================================================
-- SPIN
--==================================================

local Spinning = false
local SpinConnection

SpinButton.MouseButton1Click:Connect(function()
	Spinning = not Spinning

	if Spinning then
		SpinButton.Text = "Spin : ON"

		SpinConnection = RunService.RenderStepped:Connect(function()
			if Root then
				Root.CFrame = Root.CFrame * CFrame.Angles(0,math.rad(12),0)
			end
		end)
	else
		SpinButton.Text = "Spin : OFF"

		if SpinConnection then
			SpinConnection:Disconnect()
			SpinConnection = nil
		end
	end
end)

--==================================================
-- BIG HEAD
--==================================================

BigHeadButton.MouseButton1Click:Connect(function()
	if Character then
		local Head = Character:FindFirstChild("Head")

		if Head then
			Head.Size = Vector3.new(4,4,4)
		end
	end
end)

--==================================================
-- SMALL CHARACTER
--==================================================

SmallButton.MouseButton1Click:Connect(function()
	if Character then
		for _,obj in ipairs(Character:GetDescendants()) do
			if obj:IsA("BasePart") then
				obj.Size *= 0.5
			end
		end
	end
end)

--==================================================
-- RAINBOW
--==================================================

local RainbowRunning = false

RainbowButton.MouseButton1Click:Connect(function()
	if RainbowRunning then return end

	RainbowRunning = true

	task.spawn(function()
		while RainbowRunning and Character do
			local Hue = (tick() % 5) / 5

			for _,obj in ipairs(Character:GetDescendants()) do
				if obj:IsA("BasePart") then
					obj.Color = Color3.fromHSV(Hue,1,1)
				end
			end

			task.wait(0.1)
		end
	end)
end)

--==================================================
-- RESET
--==================================================

ResetButton.MouseButton1Click:Connect(function()
	RainbowRunning = false

	if Character then
		local Head = Character:FindFirstChild("Head")

		if Head then
			Head.Size = Vector3.new(2,1,1)
		end

		for _,obj in ipairs(Character:GetDescendants()) do
			if obj:IsA("BasePart") then
				obj.Size = Vector3.new(
					math.max(obj.Size.X,0.1),
					math.max(obj.Size.Y,0.1),
					math.max(obj.Size.Z,0.1)
				)
			end
		end
	end

	Player:LoadCharacter()
end)

--==================================================
-- PAGE SWITCHING
--==================================================

MovementButton.MouseButton1Click:Connect(function()
	MovementPage.Visible = true
	TrollPage.Visible = false
end)

TrollButton.MouseButton1Click:Connect(function()
	MovementPage.Visible = false
	TrollPage.Visible = true
end)

--==================================================
-- MOBILE FLY CONTROLS
--==================================================

if UIS.TouchEnabled then

	local Up = Instance.new("TextButton")
	Up.Size = UDim2.new(0,60,0,60)
	Up.Position = UDim2.new(1,-75,1,-150)
	Up.BackgroundColor3 = Color3.fromRGB(30,30,36)
	Up.Text = "▲"
	Up.TextColor3 = Color3.new(1,1,1)
	Up.TextSize = 24
	Up.Parent = Gui

	local Down = Instance.new("TextButton")
	Down.Size = UDim2.new(0,60,0,60)
	Down.Position = UDim2.new(1,-75,1,-80)
	Down.BackgroundColor3 = Color3.fromRGB(30,30,36)
	Down.Text = "▼"
	Down.TextColor3 = Color3.new(1,1,1)
	Down.TextSize = 24
	Down.Parent = Gui

	local UpHeld = false
	local DownHeld = false

	Up.MouseButton1Down:Connect(function()
		UpHeld = true
	end)

	Up.MouseButton1Up:Connect(function()
		UpHeld = false
	end)

	Down.MouseButton1Down:Connect(function()
		DownHeld = true
	end)

	Down.MouseButton1Up:Connect(function()
		DownHeld = false
	end)

	RunService.RenderStepped:Connect(function()
		if Flying and Root then
			local Camera = workspace.CurrentCamera
			local V = Root.AssemblyLinearVelocity

			if UpHeld then
				V += Vector3.new(0,FlySpeed,0)
			end

			if DownHeld then
				V -= Vector3.new(0,FlySpeed,0)
			end

			Root.AssemblyLinearVelocity = V
		end
	end)
end
