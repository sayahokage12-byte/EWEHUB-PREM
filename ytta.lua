--//============================================================--
--// EWEHUB PREMIUM V4 LOADER
--// Premium Authentication + User ID Auto Verification
--//============================================================--

repeat task.wait() until game:IsLoaded()

--//============================================================--
--// SERVICES
--//============================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--//============================================================--
--// CONFIGURATION
--//============================================================--

local CONFIG = {

    HUB_NAME = "EWEHUB",
    VERSION = "PREMIUM V4",

    -- MASUKKAN URL EDGE FUNCTION KAMU DI SINI
    API_URL = "doujin.desu.xxx",

    --==========================================================--
    -- GAME SCRIPTS
    -- Tambahkan PlaceId game yang didukung di sini
    --==========================================================--

    GAMES = {

        -- Contoh:
        -- [123456789] = "https://raw.githubusercontent.com/USERNAME/REPOSITORY/main/script.lua",

    },

    -- UI
    PRIMARY = Color3.fromRGB(35, 210, 150),
    PRIMARY_DARK = Color3.fromRGB(20, 170, 115),

    BACKGROUND = Color3.fromRGB(10, 14, 24),
    PANEL = Color3.fromRGB(20, 27, 40),

    TEXT = Color3.fromRGB(235, 238, 245),
    SUBTEXT = Color3.fromRGB(145, 155, 175),

    ERROR = Color3.fromRGB(255, 80, 100),
    SUCCESS = Color3.fromRGB(35, 210, 150),

}

--//============================================================--
--// HTTP REQUEST DETECTION
--//============================================================--

local Request

if syn and syn.request then
    Request = syn.request

elseif http_request then
    Request = http_request

elseif request then
    Request = request

elseif fluxus and fluxus.request then
    Request = fluxus.request

else
    warn("[EWEHUB] HTTP request function not found.")
end

--//============================================================--
--// CLEAN OLD UI
--//============================================================--

pcall(function()

    local oldUI = CoreGui:FindFirstChild("EWEHUB_PREMIUM_V4")

    if oldUI then
        oldUI:Destroy()
    end

end)

--//============================================================--
--// GUI CREATION
--//============================================================--

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "EWEHUB_PREMIUM_V4"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    ScreenGui.Parent = CoreGui
end)

if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

--//============================================================--
--// HELPER FUNCTIONS
--//============================================================--

local function CreateTween(
    Object,
    Time,
    Properties,
    Style,
    Direction
)

    local Tween = TweenService:Create(

        Object,

        TweenInfo.new(
            Time,
            Style or Enum.EasingStyle.Quint,
            Direction or Enum.EasingDirection.Out
        ),

        Properties

    )

    Tween:Play()

    return Tween

end

local function CreateCorner(Object, Radius)

    local Corner = Instance.new("UICorner")

    Corner.CornerRadius = UDim.new(0, Radius)
    Corner.Parent = Object

    return Corner

end

local function CreateStroke(
    Object,
    Color,
    Thickness,
    Transparency
)

    local Stroke = Instance.new("UIStroke")

    Stroke.Color = Color
    Stroke.Thickness = Thickness or 1
    Stroke.Transparency = Transparency or 0

    Stroke.Parent = Object

    return Stroke

end

--//============================================================--
--// MAIN CONTAINER
--//============================================================--

local Main = Instance.new("Frame")

Main.Name = "Main"
Main.Parent = ScreenGui

Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)

-- Tidak terlalu besar
Main.Size = UDim2.new(
    0.55,
    0,
    0,
    420
)

Main.BackgroundColor3 = CONFIG.BACKGROUND
Main.BorderSizePixel = 0

Main.ClipsDescendants = true

CreateCorner(Main, 18)

local MainStroke = CreateStroke(
    Main,
    Color3.fromRGB(45, 60, 85),
    1,
    0.2
)

-- Mobile scaling
local UIScale = Instance.new("UIScale")
UIScale.Parent = Main

local function UpdateScale()

    local Camera = workspace.CurrentCamera

    if not Camera then
        return
    end

    local Viewport = Camera.ViewportSize

    if Viewport.X < 700 then
        UIScale.Scale = 0.78
    else
        UIScale.Scale = 1
    end

end

UpdateScale()

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(
    UpdateScale
)

--//============================================================--
--// HEADER
--//============================================================--

local Header = Instance.new("Frame")

Header.Parent = Main

Header.Size = UDim2.new(1, 0, 0, 90)

Header.BackgroundTransparency = 1

local LogoBox = Instance.new("Frame")

LogoBox.Parent = Header

LogoBox.Position = UDim2.new(0, 24, 0.5, -25)
LogoBox.Size = UDim2.new(0, 50, 0, 50)

LogoBox.BackgroundColor3 = Color3.fromRGB(18, 25, 40)

CreateCorner(LogoBox, 12)

CreateStroke(
    LogoBox,
    Color3.fromRGB(55, 130, 220),
    2,
    0
)

local LogoText = Instance.new("TextLabel")

LogoText.Parent = LogoBox

LogoText.Size = UDim2.fromScale(1, 1)

LogoText.BackgroundTransparency = 1

LogoText.Text = "E"
LogoText.Font = Enum.Font.GothamBold

LogoText.TextColor3 = CONFIG.PRIMARY

LogoText.TextSize = 24

local HubTitle = Instance.new("TextLabel")

HubTitle.Parent = Header

HubTitle.Position = UDim2.new(0, 88, 0, 17)

HubTitle.Size = UDim2.new(0, 300, 0, 30)

HubTitle.BackgroundTransparency = 1

HubTitle.Text = CONFIG.HUB_NAME

HubTitle.TextXAlignment = Enum.TextXAlignment.Left

HubTitle.Font = Enum.Font.GothamBold

HubTitle.TextColor3 = CONFIG.TEXT

HubTitle.TextSize = 26

local VersionText = Instance.new("TextLabel")

VersionText.Parent = Header

VersionText.Position = UDim2.new(0, 90, 0, 49)

VersionText.Size = UDim2.new(0, 250, 0, 20)

VersionText.BackgroundTransparency = 1

VersionText.Text = CONFIG.VERSION

VersionText.TextXAlignment = Enum.TextXAlignment.Left

VersionText.Font = Enum.Font.GothamMedium

VersionText.TextColor3 = CONFIG.PRIMARY

VersionText.TextSize = 13

local CloseButton = Instance.new("TextButton")

CloseButton.Parent = Header

CloseButton.AnchorPoint = Vector2.new(1, 0)

CloseButton.Position = UDim2.new(1, -22, 0, 20)

CloseButton.Size = UDim2.new(0, 38, 0, 38)

CloseButton.BackgroundTransparency = 1

CloseButton.Text = "×"

CloseButton.Font = Enum.Font.GothamBold

CloseButton.TextColor3 = Color3.fromRGB(150, 160, 180)

CloseButton.TextSize = 30

CloseButton.MouseButton1Click:Connect(function()

    CreateTween(
        Main,
        0.25,
        {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        }
    )

    task.wait(0.3)

    ScreenGui:Destroy()

end)

--//============================================================--
--// CONTENT HOLDER
--//============================================================--

local Content = Instance.new("Frame")

Content.Parent = Main

Content.Position = UDim2.new(0, 0, 0, 90)

Content.Size = UDim2.new(1, 0, 1, -90)

Content.BackgroundTransparency = 1

--//============================================================--
--// PAGE SYSTEM
--//============================================================--

local CurrentPage

local function ClearPage()

    for _, Child in ipairs(Content:GetChildren()) do

        if Child:IsA("GuiObject") then
            Child:Destroy()
        end

    end

end

--//============================================================--
--// STATUS TEXT
--//============================================================--

local function CreateStatusText(

    Parent,
    Text,
    Color

)

    local Status = Instance.new("TextLabel")

    Status.Parent = Parent

    Status.AnchorPoint = Vector2.new(0.5, 0)

    Status.Position = UDim2.new(0.5, 0, 1, -42)

    Status.Size = UDim2.new(0.9, 0, 0, 25)

    Status.BackgroundTransparency = 1

    Status.Text = Text

    Status.TextColor3 = Color

    Status.Font = Enum.Font.GothamMedium

    Status.TextSize = 13

    Status.TextWrapped = true

    return Status

end

--//============================================================--
--// API REQUEST
--//============================================================--

local function SendAPI(Data)

    if not Request then

        return false, {
            success = false,
            code = "HTTP_UNAVAILABLE",
            message = "HTTP request is not supported by this executor"
        }

    end

    local Success, Result = pcall(function()

        return Request({

            Url = CONFIG.API_URL,

            Method = "POST",

            Headers = {

                ["Content-Type"] = "application/json"

            },

            Body = HttpService:JSONEncode(Data)

        })

    end)

    if not Success then

        return false, {

            success = false,

            code = "CONNECTION_FAILED",

            message = "Failed to connect to the premium server"

        }

    end

    if not Result then

        return false, {

            success = false,

            code = "EMPTY_RESPONSE",

            message = "Premium server returned no response"

        }

    end

    local Body = Result.Body or Result.body

    if not Body then

        return false, {

            success = false,

            code = "INVALID_RESPONSE",

            message = "Invalid server response"

        }

    end

    local DecodeSuccess, Response = pcall(function()

        return HttpService:JSONDecode(Body)

    end)

    if not DecodeSuccess then

        return false, {

            success = false,

            code = "JSON_ERROR",

            message = "Failed to read server response"

        }

    end

    return true, Response

end

--//============================================================--
--// GAME CHECK PAGE
--//============================================================--

local function ShowGameCheck()

    ClearPage()

    CurrentPage = "GAME_CHECK"

    -- Icon
    local Circle = Instance.new("Frame")

    Circle.Parent = Content

    Circle.AnchorPoint = Vector2.new(0.5, 0)

    Circle.Position = UDim2.new(0.5, 0, 0, 25)

    Circle.Size = UDim2.new(0, 100, 0, 100)

    Circle.BackgroundColor3 = CONFIG.PANEL

    CreateCorner(Circle, 100)

    local Diamond = Instance.new("TextLabel")

    Diamond.Parent = Circle

    Diamond.Size = UDim2.fromScale(1, 1)

    Diamond.BackgroundTransparency = 1

    Diamond.Text = "◆"

    Diamond.Font = Enum.Font.GothamBold

    Diamond.TextColor3 = CONFIG.PRIMARY

    Diamond.TextSize = 34

    -- Title
    local Title = Instance.new("TextLabel")

    Title.Parent = Content

    Title.AnchorPoint = Vector2.new(0.5, 0)

    Title.Position = UDim2.new(0.5, 0, 0, 145)

    Title.Size = UDim2.new(0.9, 0, 0, 40)

    Title.BackgroundTransparency = 1

    Title.Text = "CHECKING GAME"

    Title.Font = Enum.Font.GothamBold

    Title.TextColor3 = CONFIG.TEXT

    Title.TextSize = 25

    -- Description
    local Description = Instance.new("TextLabel")

    Description.Parent = Content

    Description.AnchorPoint = Vector2.new(0.5, 0)

    Description.Position = UDim2.new(0.5, 0, 0, 195)

    Description.Size = UDim2.new(0.9, 0, 0, 30)

    Description.BackgroundTransparency = 1

    Description.Text = "Checking game availability..."

    Description.Font = Enum.Font.Gotham

    Description.TextColor3 = CONFIG.SUBTEXT

    Description.TextSize = 15

    task.wait(1)

    local PlaceId = game.PlaceId

    local ScriptURL = CONFIG.GAMES[PlaceId]

    --==========================================================--
    -- GAME SUPPORTED
    --==========================================================--

    if ScriptURL then

        Title.Text = "GAME FOUND"

        Description.Text = "Loading EWEHUB for this game..."

        task.wait(0.8)

        local LoadSuccess, LoadError = pcall(function()

            loadstring(
                game:HttpGet(ScriptURL)
            )()

        end)

        if LoadSuccess then

            CreateTween(
                Main,
                0.3,
                {
                    BackgroundTransparency = 1
                }
            )

            task.wait(0.35)

            ScreenGui:Destroy()

        else

            Title.Text = "LOADING FAILED"

            Description.Text =
                "Failed to load the game script."

            Description.TextColor3 = CONFIG.ERROR

            warn(
                "[EWEHUB] Script Load Error:",
                LoadError
            )

        end

        return

    end

    --==========================================================--
    -- GAME NOT SUPPORTED
    --==========================================================--

    Title.Text = "GAME UNAVAILABLE"

    Description.Text =
        "This game may not be available yet."

    Description.TextColor3 = CONFIG.SUBTEXT

    local Info = Instance.new("TextLabel")

    Info.Parent = Content

    Info.AnchorPoint = Vector2.new(0.5, 0)

    Info.Position = UDim2.new(0.5, 0, 0, 245)

    Info.Size = UDim2.new(0.82, 0, 0, 50)

    Info.BackgroundTransparency = 1

    Info.Text =
        "EWEHUB is still checking support for this game."

    Info.TextWrapped = true

    Info.Font = Enum.Font.Gotham

    Info.TextColor3 = Color3.fromRGB(105, 115, 135)

    Info.TextSize = 13

end

--//============================================================--
--// PREMIUM KEY PAGE
--//============================================================--

local function ShowPremiumPage(ErrorMessage)

    ClearPage()

    CurrentPage = "PREMIUM"

    -- Icon
    local Circle = Instance.new("Frame")

    Circle.Parent = Content

    Circle.AnchorPoint = Vector2.new(0.5, 0)

    Circle.Position = UDim2.new(0.5, 0, 0, 18)

    Circle.Size = UDim2.new(0, 85, 0, 85)

    Circle.BackgroundColor3 = CONFIG.PANEL

    CreateCorner(Circle, 100)

    local Diamond = Instance.new("TextLabel")

    Diamond.Parent = Circle

    Diamond.Size = UDim2.fromScale(1, 1)

    Diamond.BackgroundTransparency = 1

    Diamond.Text = "◆"

    Diamond.Font = Enum.Font.GothamBold

    Diamond.TextColor3 = CONFIG.PRIMARY

    Diamond.TextSize = 28

    -- Title
    local Title = Instance.new("TextLabel")

    Title.Parent = Content

    Title.AnchorPoint = Vector2.new(0.5, 0)

    Title.Position = UDim2.new(0.5, 0, 0, 115)

    Title.Size = UDim2.new(0.9, 0, 0, 40)

    Title.BackgroundTransparency = 1

    Title.Text = "PREMIUM ACCESS"

    Title.Font = Enum.Font.GothamBold

    Title.TextColor3 = CONFIG.TEXT

    Title.TextSize = 24

    -- Subtitle
    local Subtitle = Instance.new("TextLabel")

    Subtitle.Parent = Content

    Subtitle.AnchorPoint = Vector2.new(0.5, 0)

    Subtitle.Position = UDim2.new(0.5, 0, 0, 160)

    Subtitle.Size = UDim2.new(0.9, 0, 0, 30)

    Subtitle.BackgroundTransparency = 1

    Subtitle.Text =
        "Enter your premium key to continue"

    Subtitle.Font = Enum.Font.Gotham

    Subtitle.TextColor3 = CONFIG.SUBTEXT

    Subtitle.TextSize = 15

    -- Input
    local KeyBox = Instance.new("TextBox")

    KeyBox.Parent = Content

    KeyBox.AnchorPoint = Vector2.new(0.5, 0)

    KeyBox.Position = UDim2.new(0.5, 0, 0, 210)

    KeyBox.Size = UDim2.new(0.72, 0, 0, 58)

    KeyBox.BackgroundColor3 = CONFIG.PANEL

    KeyBox.BorderSizePixel = 0

    CreateCorner(KeyBox, 12)

    KeyBox.PlaceholderText = "ENTER PREMIUM KEY"

    KeyBox.Text = ""

    KeyBox.TextColor3 = CONFIG.TEXT

    KeyBox.PlaceholderColor3 =
        Color3.fromRGB(120, 130, 150)

    KeyBox.Font = Enum.Font.GothamMedium

    KeyBox.TextSize = 16

    KeyBox.ClearTextOnFocus = false

    CreateStroke(
        KeyBox,
        Color3.fromRGB(40, 50, 70),
        1,
        0
    )

    -- Verify Button
    local VerifyButton = Instance.new("TextButton")

    VerifyButton.Parent = Content

    VerifyButton.AnchorPoint = Vector2.new(0.5, 0)

    VerifyButton.Position = UDim2.new(0.5, 0, 0, 285)

    VerifyButton.Size = UDim2.new(0.72, 0, 0, 58)

    VerifyButton.BackgroundColor3 = CONFIG.PRIMARY

    VerifyButton.BorderSizePixel = 0

    CreateCorner(VerifyButton, 12)

    VerifyButton.Text = "VERIFY PREMIUM"

    VerifyButton.TextColor3 = Color3.new(1, 1, 1)

    VerifyButton.Font = Enum.Font.GothamBold

    VerifyButton.TextSize = 16

    -- Status
    local Status = CreateStatusText(

        Content,

        ErrorMessage or "",

        CONFIG.ERROR

    )

    --==========================================================--
    -- VERIFY FUNCTION
    --==========================================================--

    local Verifying = false

    local function VerifyKey()

        if Verifying then
            return
        end

        local Key = KeyBox.Text

        Key = string.gsub(
            Key,
            "^%s*(.-)%s*$",
            "%1"
        )

        if Key == "" then

            Status.Text =
                "Please enter your premium key."

            Status.TextColor3 = CONFIG.ERROR

            return

        end

        Verifying = true

        VerifyButton.Text = "VERIFYING..."

        VerifyButton.BackgroundColor3 =
            CONFIG.PRIMARY_DARK

        Status.Text =
            "Connecting to premium server..."

        Status.TextColor3 = CONFIG.SUBTEXT

        task.spawn(function()

            local Success, Response = SendAPI({

                user_id = LocalPlayer.UserId,

                key = Key

            })

            if not Success then

                Status.Text =
                    Response.message or
                    "Failed to connect to the premium server."

                Status.TextColor3 = CONFIG.ERROR

                VerifyButton.Text =
                    "VERIFY PREMIUM"

                VerifyButton.BackgroundColor3 =
                    CONFIG.PRIMARY

                Verifying = false

                return

            end

            --==================================================--
            -- SUCCESS
            --==================================================--

            if Response.success == true then

                Status.Text =
                    Response.message or
                    "Premium verified successfully."

                Status.TextColor3 =
                    CONFIG.SUCCESS

                VerifyButton.Text = "SUCCESS"

                task.wait(0.7)

                ShowGameCheck()

                return

            end

            --==================================================--
            -- ERROR
            --==================================================--

            Status.Text =
                Response.message or
                "Premium verification failed."

            Status.TextColor3 =
                CONFIG.ERROR

            VerifyButton.Text =
                "VERIFY PREMIUM"

            VerifyButton.BackgroundColor3 =
                CONFIG.PRIMARY

            Verifying = false

        end)

    end

    VerifyButton.MouseButton1Click:Connect(
        VerifyKey
    )

    KeyBox.FocusLost:Connect(function(EnterPressed)

        if EnterPressed then
            VerifyKey()
        end

    end)

end

--//============================================================--
--// AUTO USER ID VERIFICATION
--//============================================================--

local function StartPremiumCheck()

    ClearPage()

    -- Loading page
    local Loading = Instance.new("TextLabel")

    Loading.Parent = Content

    Loading.AnchorPoint = Vector2.new(0.5, 0.5)

    Loading.Position = UDim2.fromScale(0.5, 0.45)

    Loading.Size = UDim2.new(0.9, 0, 0, 50)

    Loading.BackgroundTransparency = 1

    Loading.Text = "CHECKING PREMIUM ACCESS..."

    Loading.Font = Enum.Font.GothamBold

    Loading.TextColor3 = CONFIG.TEXT

    Loading.TextSize = 20

    local LoadingSub = Instance.new("TextLabel")

    LoadingSub.Parent = Content

    LoadingSub.AnchorPoint = Vector2.new(0.5, 0.5)

    LoadingSub.Position = UDim2.fromScale(0.5, 0.56)

    LoadingSub.Size = UDim2.new(0.9, 0, 0, 30)

    LoadingSub.BackgroundTransparency = 1

    LoadingSub.Text =
        "Verifying your Roblox account..."

    LoadingSub.Font = Enum.Font.Gotham

    LoadingSub.TextColor3 = CONFIG.SUBTEXT

    LoadingSub.TextSize = 14

    task.spawn(function()

        local Success, Response = SendAPI({

            user_id = LocalPlayer.UserId

        })

        --======================================================--
        -- CONNECTION ERROR
        --======================================================--

        if not Success then

            ShowPremiumPage(
                "Failed to connect to the premium server."
            )

            return

        end

        --======================================================--
        -- USER SUDAH PUNYA PREMIUM
        --======================================================--

        if
            Response.success == true
            and Response.code == "VERIFIED"
        then

            ShowGameCheck()

            return

        end

        --======================================================--
        -- USER BELUM TERDAFTAR
        --======================================================--

        if Response.code == "USER_NOT_FOUND" then

            ShowPremiumPage()

            return

        end

        --======================================================--
        -- KEY DISABLED / EXPIRED
        --======================================================--

        if Response.code == "KEY_DISABLED" then

            ShowPremiumPage(
                "Your premium access has been disabled."
            )

            return

        end

        if Response.code == "KEY_EXPIRED" then

            ShowPremiumPage(
                "Your premium access has expired."
            )

            return

        end

        --======================================================--
        -- OTHER ERROR
        --======================================================--

        ShowPremiumPage(
            Response.message or
            "Premium verification failed."
        )

    end)

end

--//============================================================--
--// START
--//============================================================--

Main.BackgroundTransparency = 1

Main.Size = UDim2.new(
    0.45,
    0,
    0,
    360
)

CreateTween(

    Main,

    0.35,

    {

        BackgroundTransparency = 0,

        Size = UDim2.new(
            0.55,
            0,
            0,
            420
        )

    }

)

task.wait(0.15)

StartPremiumCheck()
