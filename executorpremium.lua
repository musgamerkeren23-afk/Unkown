-- 💀 H4LL0 EXECUTOR GOD VERSION FULL + CREDITS

if not game:IsLoaded() then game.Loaded:Wait() end

local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

--------------------------------------------------
-- 🎨 THEME
--------------------------------------------------
local DARK = Color3.fromRGB(20,0,0)
local RED = Color3.fromRGB(255,0,0)

local function stroke(obj)
    local s = Instance.new("UIStroke")
    s.Color = RED
    s.Thickness = 2
    s.Parent = obj
end

--------------------------------------------------
-- 🔑 KEY SYSTEM
--------------------------------------------------
local KEYS = {
    ["H4LL0_3X3CUT0R_B4S1C"] = true,
    ["H4!l0#W0rLd$Hub_9XkP@27!zQ"] = "vip"
}

local KEY_FILE = "key.json"
local savedKey

if isfile and isfile(KEY_FILE) then
    savedKey = HttpService:JSONDecode(readfile(KEY_FILE))
end

local function valid(k,t)
    local d = KEYS[k]
    if not d then return false end
    if d=="vip" then return true end
    return (os.time()-t<=86400)
end

local function saveKey(k)
    writefile(KEY_FILE,HttpService:JSONEncode({key=k,time=os.time()}))
end

--------------------------------------------------
-- 💾 SAVED SCRIPT
--------------------------------------------------
local FILE_SCRIPT = "saved_scripts.json"
local saved = {}

if isfile and isfile(FILE_SCRIPT) then
    saved = HttpService:JSONDecode(readfile(FILE_SCRIPT))
end

local function saveData()
    writefile(FILE_SCRIPT,HttpService:JSONEncode(saved))
end

local function runScript(code)
    pcall(function() loadstring(code)() end)
end

--------------------------------------------------
-- ⏪ REWIND
--------------------------------------------------
local recording = false
local data = {}

RunService.RenderStepped:Connect(function()
    if recording then
        table.insert(data, hrp.CFrame)
        if #data > 3000 then
            table.remove(data,1)
        end
    end
end)

local function rewindFunc()
    for i = #data,1,-1 do
        hrp.CFrame = data[i]
        task.wait()
    end
end

--------------------------------------------------
-- 📱 GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui",player.PlayerGui)

--------------------------------------------------
-- 💀 LOGO INTRO
--------------------------------------------------
local logo = Instance.new("TextLabel",gui)
logo.Size = UDim2.new(1,0,1,0)
logo.BackgroundColor3 = Color3.new(0,0,0)
logo.Text = "💀"
logo.TextScaled = true
logo.TextColor3 = RED

TweenService:Create(logo,TweenInfo.new(1),{
    TextTransparency = 1
}):Play()

task.wait(1)
logo:Destroy()

--------------------------------------------------
-- LOGIN
--------------------------------------------------
local login = Instance.new("Frame",gui)
login.Size = UDim2.new(0,300,0,150)
login.Position = UDim2.new(0.35,0,0.35,0)
login.BackgroundColor3 = DARK
stroke(login)

local box = Instance.new("TextBox",login)
box.Size = UDim2.new(0.8,0,0,40)
box.Position = UDim2.new(0.1,0,0.3,0)
box.TextColor3 = RED
box.BackgroundColor3 = DARK
stroke(box)

local btn = Instance.new("TextButton",login)
btn.Size = UDim2.new(0.8,0,0,40)
btn.Position = UDim2.new(0.1,0,0.6,0)
btn.Text = "VERIFY"
btn.TextColor3 = RED
btn.BackgroundColor3 = DARK
stroke(btn)

--------------------------------------------------
-- MAIN FRAME
--------------------------------------------------
local frame = Instance.new("Frame",gui)
frame.Size = UDim2.new(0,420,0,320)
frame.Position = UDim2.new(0.3,0,1,0)
frame.BackgroundColor3 = DARK
frame.Visible = false
frame.Active = true
stroke(frame)

local title = Instance.new("TextLabel",frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "3X3CUT0R H3LL0 PRO💀"
title.TextColor3 = RED
title.BackgroundTransparency = 1

--------------------------------------------------
-- ⚡ GLITCH
--------------------------------------------------
local function glitch()
    for i=1,6 do
        frame.Position = frame.Position + UDim2.new(0,math.random(-5,5),0,math.random(-5,5))
        task.wait(0.03)
    end
end

--------------------------------------------------
-- INTRO
--------------------------------------------------
local function intro()
    frame.Visible = true
    TweenService:Create(frame,TweenInfo.new(0.5),{
        Position = UDim2.new(0.3,0,0.3,0)
    }):Play()
    glitch()
end

--------------------------------------------------
-- MINIMIZE
--------------------------------------------------
local mini = Instance.new("TextButton",gui)
mini.Size = UDim2.new(0,50,0,50)
mini.Position = UDim2.new(0.05,0,0.4,0)
mini.Text = "💀"
mini.Visible = false
mini.BackgroundColor3 = DARK
mini.TextColor3 = RED
stroke(mini)

local close = Instance.new("TextButton",frame)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,0)
close.Text = "X"
close.BackgroundColor3 = DARK
close.TextColor3 = RED
stroke(close)

--------------------------------------------------
-- TABS
--------------------------------------------------
local tabs = {"Executor","Saved","Rewind","Credits"}
local pages = {}

for i,name in ipairs(tabs) do
    local tab = Instance.new("TextButton",frame)
    tab.Size = UDim2.new(1/#tabs,0,0,30)
    tab.Position = UDim2.new((i-1)/#tabs,0,0,30)
    tab.Text = name
    tab.BackgroundColor3 = DARK
    tab.TextColor3 = RED
    stroke(tab)

    local page = Instance.new("Frame",frame)
    page.Size = UDim2.new(1,0,1,-60)
    page.Position = UDim2.new(0,0,0,60)
    page.Visible = (i==1)

    pages[i]=page

    tab.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible=false end
        page.Visible=true
    end)
end

--------------------------------------------------
-- EXECUTOR
--------------------------------------------------
local url = Instance.new("TextBox",pages[1])
url.Size = UDim2.new(0.9,0,0,40)
url.Position = UDim2.new(0.05,0,0.2,0)
url.PlaceholderText = "RAW URL..."
url.TextColor3 = RED
url.BackgroundColor3 = DARK
stroke(url)

local run = Instance.new("TextButton",pages[1])
run.Size = UDim2.new(0.9,0,0,40)
run.Position = UDim2.new(0.05,0,0.5,0)
run.Text = "EXECUTE"
run.TextColor3 = RED
run.BackgroundColor3 = DARK
stroke(run)

run.MouseButton1Click:Connect(function()
    local ok,res = pcall(function()
        return game:HttpGet(url.Text)
    end)
    if ok then pcall(function() loadstring(res)() end) end
end)

--------------------------------------------------
-- SAVED
--------------------------------------------------
local savedPage = pages[2]

local add = Instance.new("TextButton",savedPage)
add.Size = UDim2.new(0,40,0,40)
add.Position = UDim2.new(0,5,0,5)
add.Text = "+"
add.TextColor3 = RED
add.BackgroundColor3 = DARK
stroke(add)

local popup = Instance.new("Frame",gui)
popup.Size = UDim2.new(0,300,0,200)
popup.Position = UDim2.new(0.35,0,0.35,0)
popup.Visible = false
popup.BackgroundColor3 = DARK
stroke(popup)

local nameBox = Instance.new("TextBox",popup)
nameBox.Size = UDim2.new(0.9,0,0,40)
nameBox.Position = UDim2.new(0.05,0,0.1,0)
nameBox.PlaceholderText = "Name"
nameBox.TextColor3 = RED
nameBox.BackgroundColor3 = DARK

local codeBox = Instance.new("TextBox",popup)
codeBox.Size = UDim2.new(0.9,0,0,60)
codeBox.Position = UDim2.new(0.05,0,0.4,0)
codeBox.PlaceholderText = "Script"
codeBox.MultiLine = true
codeBox.TextColor3 = RED
codeBox.BackgroundColor3 = DARK

local saveBtn = Instance.new("TextButton",popup)
saveBtn.Size = UDim2.new(0.9,0,0,40)
saveBtn.Position = UDim2.new(0.05,0,0.75,0)
saveBtn.Text = "SAVE"
saveBtn.TextColor3 = RED
saveBtn.BackgroundColor3 = DARK
stroke(saveBtn)

local function refresh()
    for _,v in pairs(savedPage:GetChildren()) do
        if v.Name=="Item" then v:Destroy() end
    end

    for i,v in ipairs(saved) do
        local y = 50 + (i-1)*50

        local btn = Instance.new("TextButton",savedPage)
        btn.Name="Item"
        btn.Size = UDim2.new(0.6,0,0,40)
        btn.Position = UDim2.new(0.05,0,0,y)
        btn.Text = v.name
        btn.TextColor3 = RED
        btn.BackgroundColor3 = DARK
        stroke(btn)

        local run = Instance.new("TextButton",savedPage)
        run.Name="Item"
        run.Size = UDim2.new(0.15,0,0,40)
        run.Position = UDim2.new(0.67,0,0,y)
        run.Text = "▶"
        run.TextColor3 = RED
        run.BackgroundColor3 = DARK
        stroke(run)

        local del = Instance.new("TextButton",savedPage)
        del.Name="Item"
        del.Size = UDim2.new(0.15,0,0,40)
        del.Position = UDim2.new(0.83,0,0,y)
        del.Text = "X"
        del.TextColor3 = RED
        del.BackgroundColor3 = DARK
        stroke(del)

        run.MouseButton1Click:Connect(function()
            runScript(v.code)
        end)

        del.MouseButton1Click:Connect(function()
            table.remove(saved,i)
            saveData()
            refresh()
        end)
    end
end

add.MouseButton1Click:Connect(function()
    popup.Visible = true
end)

saveBtn.MouseButton1Click:Connect(function()
    table.insert(saved,{
        name=nameBox.Text,
        code=codeBox.Text
    })
    saveData()
    popup.Visible = false
    refresh()
end)

refresh()

--------------------------------------------------
-- REWIND
--------------------------------------------------
local rec = Instance.new("TextButton",pages[3])
rec.Size = UDim2.new(0.8,0,0,40)
rec.Position = UDim2.new(0.1,0,0.2,0)
rec.Text = "RECORD"
rec.TextColor3 = RED
rec.BackgroundColor3 = DARK
stroke(rec)

local rew = Instance.new("TextButton",pages[3])
rew.Size = UDim2.new(0.8,0,0,40)
rew.Position = UDim2.new(0.1,0,0.5,0)
rew.Text = "REWIND"
rew.TextColor3 = RED
rew.BackgroundColor3 = DARK
stroke(rew)

local reset = Instance.new("TextButton",pages[3])
reset.Size = UDim2.new(0.8,0,0,40)
reset.Position = UDim2.new(0.1,0,0.75,0)
reset.Text = "RESET"
reset.TextColor3 = RED
reset.BackgroundColor3 = DARK
stroke(reset)

rec.MouseButton1Click:Connect(function()
    recording = not recording
    rec.Text = recording and "STOP" or "RECORD"
end)

rew.MouseButton1Click:Connect(rewindFunc)

reset.MouseButton1Click:Connect(function()
    data = {}
end)

--------------------------------------------------
-- 📜 CREDITS
--------------------------------------------------
local creditsPage = pages[4]

local scroll = Instance.new("ScrollingFrame",creditsPage)
scroll.Size = UDim2.new(1,0,1,0)
scroll.CanvasSize = UDim2.new(0,0,0,2000)
scroll.BackgroundTransparency = 1

local txt = Instance.new("TextLabel",scroll)
txt.Size = UDim2.new(1,-20,0,2000)
txt.Position = UDim2.new(0,10,0,0)
txt.TextColor3 = RED
txt.TextWrapped = true
txt.TextYAlignment = Enum.TextYAlignment.Top
txt.BackgroundTransparency = 1
txt.Font = Enum.Font.Code

txt.Text = [[
💀 H4LL0 EXECUTOR GOD VERSION 💀

GUI BY: SCRIPT SYSTEM
SCRIPT BY: CHATGPT
IDEA BY: H4LL0 DEV

THANKS TO:
ROBLOX ENGINE
LUA SYSTEM
COMMUNITY

THIS SYSTEM IS BUILT FOR
FULL UI EXPERIENCE

VERSION:
V1 BASIC
V2 REWIND
V3 SAVED
V4 UI
V5 GOD

💀 THE SYSTEM IS WATCHING 💀























































































































]]
task.spawn(function()
    while true do
        scroll.CanvasPosition = scroll.CanvasPosition + Vector2.new(0,1)
        task.wait(0.03)
    end
end)

--------------------------------------------------
-- LOGIN
--------------------------------------------------
if savedKey and valid(savedKey.key,savedKey.time) then
    login.Visible=false
    intro()
end

btn.MouseButton1Click:Connect(function()
    if valid(box.Text,os.time()) then
        saveKey(box.Text)
        login.Visible=false
        intro()
    end
end)

--------------------------------------------------
-- MINIMIZE
--------------------------------------------------
close.MouseButton1Click:Connect(function()
    frame.Visible=false
    mini.Visible=true
end)

mini.MouseButton1Click:Connect(function()
    frame.Visible=true
    mini.Visible=false
end)

--------------------------------------------------
-- DRAG
--------------------------------------------------
local dragging,start,pos

frame.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then
        dragging=true
        start=i.Position
        pos=frame.Position
    end
end)

frame.InputChanged:Connect(function(i)
    if dragging then
        local delta=i.Position-start
        frame.Position=UDim2.new(pos.X.Scale,pos.X.Offset+delta.X,pos.Y.Scale,pos.Y.Offset+delta.Y)
    end
end)

frame.InputEnded:Connect(function()
    dragging=false
end)
