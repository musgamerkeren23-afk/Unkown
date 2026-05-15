if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local DARK = Color3.fromRGB(20, 0, 0)
local RED = Color3.fromRGB(220, 0, 0)
local WHITE = Color3.fromRGB(255, 255, 255)

local function stroke(obj)
    local s = Instance.new("UIStroke")
    s.Color = RED
    s.Thickness = 1
    s.Parent = obj
end

local function makeLabel(parent, text, size, x, y, w, h)
    local l = Instance.new("TextLabel")
    l.Parent = parent
    l.Text = text
    l.TextColor3 = RED
    l.TextSize = size or 13
    l.Font = Enum.Font.GothamBold
    l.BackgroundTransparency = 1
    l.Size = UDim2.new(0, w or 200, 0, h or 30)
    l.Position = UDim2.new(0, x or 0, 0, y or 0)
    l.TextXAlignment = Enum.TextXAlignment.Left
    return l
end

local function makeBtn(parent, text, x, y, w, h)
    local b = Instance.new("TextButton")
    b.Parent = parent
    b.Text = text
    b.TextColor3 = RED
    b.TextSize = 12
    b.Font = Enum.Font.GothamBold
    b.BackgroundColor3 = DARK
    b.BorderSizePixel = 0
    b.Size = UDim2.new(0, w or 100, 0, h or 34)
    b.Position = UDim2.new(0, x or 0, 0, y or 0)
    stroke(b)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    return b
end

local function makeBox(parent, placeholder, x, y, w, h, multi)
    local b = Instance.new("TextBox")
    b.Parent = parent
    b.PlaceholderText = placeholder or ""
    b.PlaceholderColor3 = Color3.fromRGB(80, 0, 0)
    b.Text = ""
    b.TextColor3 = RED
    b.TextSize = 12
    b.Font = Enum.Font.Gotham
    b.BackgroundColor3 = DARK
    b.BorderSizePixel = 0
    b.ClearTextOnFocus = false
    b.MultiLine = multi or false
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Size = UDim2.new(0, w or 200, 0, h or 34)
    b.Position = UDim2.new(0, x or 0, 0, y or 0)
    stroke(b)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    return b
end

-- ══════════════════════════════
--         KEY SYSTEM
-- ══════════════════════════════

local KEYS = {
    ["H4LL0_3X3CUT0R_B4S1C"] = true,
    ["VIP_FULL_ACCESS"] = "vip"
}

local KEY_FILE = "key.json"
local savedKey

pcall(function()
    if isfile(KEY_FILE) then
        savedKey = HttpService:JSONDecode(readfile(KEY_FILE))
    end
end)

local function valid(k, t)
    local d = KEYS[k]
    if not d then return false end
    if d == "vip" then return true end
    return (os.time() - t <= 86400)
end

local function saveKey(k)
    pcall(function()
        writefile(KEY_FILE, HttpService:JSONEncode({key = k, time = os.time()}))
    end)
end

-- ══════════════════════════════
--         SAVED SCRIPTS
-- ══════════════════════════════

local FILE_SCRIPT = "saved_scripts.json"
local saved = {}

pcall(function()
    if isfile(FILE_SCRIPT) then
        saved = HttpService:JSONDecode(readfile(FILE_SCRIPT))
    end
end)

local function saveData()
    pcall(function()
        writefile(FILE_SCRIPT, HttpService:JSONEncode(saved))
    end)
end

local function runScript(code)
    pcall(function() loadstring(code)() end)
end

-- ══════════════════════════════
--         REWIND
-- ══════════════════════════════

local recording = false
local rewindData = {}

RunService.RenderStepped:Connect(function()
    if recording then
        table.insert(rewindData, hrp.CFrame)
        if #rewindData > 3000 then table.remove(rewindData, 1) end
    end
end)

local function rewindFunc()
    for i = #rewindData, 1, -1 do
        hrp.CFrame = rewindData[i]
        task.wait()
    end
end

-- ══════════════════════════════
--         GUI
-- ══════════════════════════════

local gui = Instance.new("ScreenGui")
gui.Name = "H4ll0Executor"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

-- Intro logo
local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 1, 0)
logo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
logo.Text = "💀"
logo.TextSize = 80
logo.Font = Enum.Font.GothamBold
logo.TextColor3 = RED
logo.ZIndex = 99
logo.Parent = gui

TweenService:Create(logo, TweenInfo.new(1), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
task.wait(1.2)
logo:Destroy()

-- ══════════════════════════════
--         LOGIN FRAME
-- ══════════════════════════════

local login = Instance.new("Frame")
login.Size = UDim2.new(0, 320, 0, 160)
login.Position = UDim2.new(0.5, -160, 0.5, -80)
login.BackgroundColor3 = DARK
login.BorderSizePixel = 0
login.Parent = gui
stroke(login)
Instance.new("UICorner", login).CornerRadius = UDim.new(0, 10)

makeLabel(login, "💀 h4ll0 w0rld | Key System", 13, 10, 8, 280, 26)

local keyBox = makeBox(login, "Enter key here...", 10, 42, 300, 36)
local keyStatus = makeLabel(login, "", 11, 10, 82, 300, 18)
local verifyBtn = makeBtn(login, "🔑 Verify", 10, 108, 300, 36)

-- ══════════════════════════════
--         MAIN FRAME
-- ══════════════════════════════

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 440, 0, 340)
frame.Position = UDim2.new(0.5, -220, 1, 0)
frame.BackgroundColor3 = DARK
frame.BorderSizePixel = 0
frame.Visible = false
frame.Active = true
frame.Parent = gui
stroke(frame)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
titleBar.BorderSizePixel = 0
titleBar.Parent = frame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

makeLabel(titleBar, "💀 H4LL0 EXECUTOR GOD", 14, 46, 0, 300, 40)

local titleIcon = Instance.new("TextLabel")
titleIcon.Size = UDim2.new(0, 36, 1, 0)
titleIcon.Position = UDim2.new(0, 8, 0, 0)
titleIcon.BackgroundTransparency = 1
titleIcon.Text = "💀"
titleIcon.TextSize = 20
titleIcon.Font = Enum.Font.GothamBold
titleIcon.Parent = titleBar

local closeBtn = makeBtn(titleBar, "✕", 406, 5, 28, 28)
closeBtn.TextSize = 13

local sep = Instance.new("Frame")
sep.Size = UDim2.new(1, -20, 0, 1)
sep.Position = UDim2.new(0, 10, 0, 44)
sep.BackgroundColor3 = RED
sep.BorderSizePixel = 0
sep.Parent = frame

-- ══════════════════════════════
--           TABS
-- ══════════════════════════════

local tabNames = {"⚡ Executor", "💾 Saved", "⏪ Rewind", "📜 Credits"}
local pages = {}
local activeTab = nil

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, 32)
tabBar.Position = UDim2.new(0, 10, 0, 50)
tabBar.BackgroundTransparency = 1
tabBar.Parent = frame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 4)
tabLayout.Parent = tabBar

local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -20, 1, -90)
contentArea.Position = UDim2.new(0, 10, 0, 86)
contentArea.BackgroundTransparency = 1
contentArea.Parent = frame

local function switchTab(idx, btn)
    for i, p in ipairs(pages) do p.Visible = (i == idx) end
    if activeTab then
        activeTab.BackgroundColor3 = DARK
        activeTab.TextColor3 = Color3.fromRGB(120, 0, 0)
    end
    btn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    btn.TextColor3 = RED
    activeTab = btn
end

for i, name in ipairs(tabNames) do
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0, 96, 1, 0)
    tab.BackgroundColor3 = DARK
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(120, 0, 0)
    tab.TextSize = 11
    tab.Font = Enum.Font.GothamBold
    tab.BorderSizePixel = 0
    tab.Parent = tabBar
    stroke(tab)
    Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 6)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = RED
    page.Visible = (i == 1)
    page.Parent = contentArea

    pages[i] = page

    tab.MouseButton1Click:Connect(function()
        switchTab(i, tab)
    end)

    if i == 1 then
        activeTab = tab
        tab.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
        tab.TextColor3 = RED
    end
end

-- ══════════════════════════════
--         EXECUTOR TAB
-- ══════════════════════════════

local urlBox = makeBox(pages[1], "Masukkan RAW URL script...", 0, 10, 400, 40)
urlBox.Size = UDim2.new(1, 0, 0, 40)

local runBtn = makeBtn(pages[1], "▶ RUN SCRIPT", 0, 58, 200, 36)
local clearBtn = makeBtn(pages[1], "🗑 CLEAR", 210, 58, 100, 36)

runBtn.MouseButton1Click:Connect(function()
    runBtn.Text = "⏳ Loading..."
    local ok, res = pcall(function()
        return game:HttpGet(urlBox.Text)
    end)
    if ok then
        pcall(function() loadstring(res)() end)
        runBtn.Text = "✅ Done!"
    else
        runBtn.Text = "❌ Failed!"
    end
    task.wait(2)
    runBtn.Text = "▶ RUN SCRIPT"
end)

clearBtn.MouseButton1Click:Connect(function()
    urlBox.Text = ""
end)

-- ══════════════════════════════
--         SAVED TAB
-- ══════════════════════════════

local addBtn = makeBtn(pages[2], "+ Add Script", 0, 5, 130, 32)

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 320, 0, 220)
popup.Position = UDim2.new(0.5, -160, 0.5, -110)
popup.BackgroundColor3 = DARK
popup.BorderSizePixel = 0
popup.Visible = false
popup.ZIndex = 10
popup.Parent = gui
stroke(popup)
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 10)

makeLabel(popup, "💾 Save Script", 13, 10, 8, 200, 26)
local nameBox = makeBox(popup, "Nama script...", 10, 38, 300, 34)
local codeBox = makeBox(popup, "Kode script...", 10, 80, 300, 70, true)
local saveScriptBtn = makeBtn(popup, "💾 SAVE", 10, 160, 140, 34)
local cancelBtn = makeBtn(popup, "✕ Cancel", 160, 160, 140, 34)

local savedList = Instance.new("Frame")
savedList.Size = UDim2.new(1, 0, 1, -44)
savedList.Position = UDim2.new(0, 0, 0, 44)
savedList.BackgroundTransparency = 1
savedList.Parent = pages[2]

local savedLayout = Instance.new("UIListLayout")
savedLayout.Padding = UDim.new(0, 6)
savedLayout.Parent = savedList

local function refreshSaved()
    for _, v in pairs(savedList:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    for i, v in ipairs(saved) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 38)
        row.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
        row.BorderSizePixel = 0
        row.Parent = savedList
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
        stroke(row)

        local nameLbl = makeLabel(row, v.name, 12, 8, 0, 240, 38)
        local runS = makeBtn(row, "▶", 256, 4, 34, 30)
        local delS = makeBtn(row, "✕", 296, 4, 34, 30)

        runS.MouseButton1Click:Connect(function() runScript(v.code) end)
        delS.MouseButton1Click:Connect(function()
            table.remove(saved, i)
            saveData()
            refreshSaved()
        end)
    end
end

addBtn.MouseButton1Click:Connect(function() popup.Visible = true end)
cancelBtn.MouseButton1Click:Connect(function() popup.Visible = false end)
saveScriptBtn.MouseButton1Click:Connect(function()
    if nameBox.Text ~= "" and codeBox.Text ~= "" then
        table.insert(saved, {name = nameBox.Text, code = codeBox.Text})
        saveData()
        refreshSaved()
        nameBox.Text = ""
        codeBox.Text = ""
        popup.Visible = false
    end
end)

refreshSaved()

-- ══════════════════════════════
--         REWIND TAB
-- ══════════════════════════════

local recBtn = makeBtn(pages[3], "⏺ RECORD", 0, 10, 200, 36)
local rewBtn = makeBtn(pages[3], "⏪ REWIND", 0, 54, 200, 36)
local resetBtn = makeBtn(pages[3], "🗑 RESET DATA", 0, 98, 200, 36)

local rewindStatus = makeLabel(pages[3], "Status: Idle", 12, 0, 142, 300, 20)

recBtn.MouseButton1Click:Connect(function()
    recording = not recording
    recBtn.Text = recording and "⏹ STOP" or "⏺ RECORD"
    rewindStatus.Text = recording and "Status: Recording..." or "Status: Stopped"
end)

rewBtn.MouseButton1Click:Connect(function()
    rewindStatus.Text = "Status: Rewinding..."
    rewindFunc()
    rewindStatus.Text = "Status: Done!"
end)

resetBtn.MouseButton1Click:Connect(function()
    rewindData = {}
    rewindStatus.Text = "Status: Data cleared!"
end)

-- ══════════════════════════════
--         CREDITS TAB
-- ══════════════════════════════

local creditsScroll = pages[4]
creditsScroll.CanvasSize = UDim2.new(0, 0, 0, 600)

local creditsText = Instance.new("TextLabel")
creditsText.Size = UDim2.new(1, -10, 0, 600)
creditsText.Position = UDim2.new(0, 5, 0, 0)
creditsText.BackgroundTransparency = 1
creditsText.TextColor3 = RED
creditsText.TextSize = 12
creditsText.Font = Enum.Font.GothamBold
creditsText.TextWrapped = true
creditsText.TextYAlignment = Enum.TextYAlignment.Top
creditsText.TextXAlignment = Enum.TextXAlignment.Left
creditsText.Text = [[
💀 H4LL0 EXECUTOR GOD VERSION 💀

GUI BY: H4LL0 W0RLD DEV
SCRIPT BY: H4LL0 W0RLD DEV
IDEA BY: H4LL0 W0RLD DEV

FEATURES:
- KEY SYSTEM
- EXECUTOR (RUN BY URL)
- SAVED SCRIPTS
- REWIND SYSTEM
- GLITCH INTRO

VERSIONS:
V1 - BASIC
V2 - REWIND
V3 - SAVED SCRIPTS
V4 - FULL UI
V5 - GOD VERSION

THANKS TO:
- ROBLOX ENGINE
- LUA COMMUNITY
- H4LL0 W0RLD FANS

💀 THE SYSTEM IS WATCHING 💀
]]
creditsText.Parent = creditsScroll

-- Auto scroll credits
task.spawn(function()
    while creditsText and creditsText.Parent do
        creditsScroll.CanvasPosition = creditsScroll.CanvasPosition + Vector2.new(0, 0.5)
        if creditsScroll.CanvasPosition.Y >= 560 then
            creditsScroll.CanvasPosition = Vector2.new(0, 0)
        end
        task.wait(0.03)
    end
end)

-- ══════════════════════════════
--         GLITCH EFFECT
-- ══════════════════════════════

local function glitch()
    local orig = frame.Position
    for i = 1, 6 do
        frame.Position = UDim2.new(
            orig.X.Scale, orig.X.Offset + math.random(-6, 6),
            orig.Y.Scale, orig.Y.Offset + math.random(-6, 6)
        )
        task.wait(0.03)
    end
    frame.Position = orig
end

-- ══════════════════════════════
--         INTRO
-- ══════════════════════════════

local function intro()
    frame.Visible = true
    TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
        Position = UDim2.new(0.5, -220, 0.5, -170)
    }):Play()
    task.wait(0.3)
    glitch()
end

-- ══════════════════════════════
--         MINIMIZE BUTTON
-- ══════════════════════════════

local mini = makeBtn(gui, "💀", 10, 0, 44, 44)
mini.Position = UDim2.new(0, 10, 0.5, -22)
mini.Visible = false

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
        Position = UDim2.new(0.5, -220, 1, 0)
    }):Play()
    task.wait(0.3)
    frame.Visible = false
    mini.Visible = true
end)

mini.MouseButton1Click:Connect(function()
    frame.Visible = true
    mini.Visible = false
    intro()
end)

-- ══════════════════════════════
--         DRAG (FIXED)
-- ══════════════════════════════

local dragging, dragStart, startPos = false, nil, nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
       input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ══════════════════════════════
--         KEY VERIFY
-- ══════════════════════════════

local function verifyKey(input)
    if valid(input, os.time()) then
        saveKey(input)
        keyStatus.TextColor3 = Color3.fromRGB(0, 180, 0)
        keyStatus.Text = "✅ Key valid! Loading..."
        task.wait(0.8)
        TweenService:Create(login, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        task.wait(0.4)
        login:Destroy()
        intro()
    else
        keyStatus.TextColor3 = Color3.fromRGB(220, 0, 0)
        keyStatus.Text = "❌ Key salah! Coba lagi."
        local orig = login.Position
        for i = 1, 3 do
            TweenService:Create(login, TweenInfo.new(0.04), {
                Position = UDim2.new(orig.X.Scale, orig.X.Offset + 10, orig.Y.Scale, orig.Y.Offset)
            }):Play()
            task.wait(0.04)
            TweenService:Create(login, TweenInfo.new(0.04), {
                Position = UDim2.new(orig.X.Scale, orig.X.Offset - 10, orig.Y.Scale, orig.Y.Offset)
            }):Play()
            task.wait(0.04)
        end
        TweenService:Create(login, TweenInfo.new(0.05), {Position = orig}):Play()
    end
end

if savedKey and valid(savedKey.key, savedKey.time) then
    login.Visible = false
    intro()
end

verifyBtn.MouseButton1Click:Connect(function() verifyKey(keyBox.Text) end)
keyBox.FocusLost:Connect(function(enter) if enter then verifyKey(keyBox.Text) end end)

print("💀 H4ll0 W0rld Executor loaded!")
