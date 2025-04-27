-- Load Fluent and related libraries
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Create Window
local Window = Fluent:CreateWindow({
    Title = "Compass Hub " .. Fluent.Version,
    SubTitle = "by NotEnoughJack",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Button Data (can be modified externally if needed)
local ButtonData = {
    { Title = "Deadrails", Description = "Last checked 4/26/25", ScriptPath = "gumanba/Scripts/refs/heads/main/DeadRails" },
    { Title = "Deadrails Auto", Description = "Last checked 4/26/25", ScriptPath = "gumanba/Scripts/refs/heads/main/DeadRailsAuto" },
    { Title = "Infinite Yield", Description = "Last checked 4/26/25", ScriptPath = "edgeiy/infiniteyield/master/source" },
    { Title = "Flight", Description = "X To Fly", ScriptPath = "gyyfyu/test2/refs/heads/main/no%20key%20system/fly.lua" },
    { Title = "Train Button", Description = "Made for JJS", ScriptPath = "NotEnoughJack/trainbutton/refs/heads/main/trainbutton" },
    { Title = "Teleport", Description = "C To Teleport", ScriptPath = "gyyfyu/test2/refs/heads/main/no%20key%20system/teleport.lua" },
    { Title = "Simple Domain", Description = "Made for JJS Y To Activate", ScriptPath = "gyyfyu/test2/refs/heads/main/no%20key%20system/simple%20domain.lua" },
    { Title = "Lock on", Description = "J To Toggle | Right Mouse button to lock", ScriptPath = "gyyfyu/test2/refs/heads/main/no%20key%20system/lockon.lua" },
    { Title = "Jujustu Shenanigans", Description = "Custom Character The middle", ScriptPath = "NotEnoughJack/trainbutton/refs/heads/main/themiddle" },
    { Title = "Jerk off", Description = "Click to jerk", ScriptPath = "NotEnoughJack/trainbutton/refs/heads/main/jerk" },
    -- Add more buttons here as needed...
}

-- Function to add buttons dynamically
local function AddButton(button)
    Tabs.Main:AddButton({
        Title = button.Title,
        Description = button.Description,
        Callback = function()
            Window:Dialog({
                Title = button.Title,
                Content = button.Description,
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            -- Dynamically execute the script on button click
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/" .. button.ScriptPath))()
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })
end

-- Add Buttons to the Interface
for _, button in ipairs(ButtonData) do
    AddButton(button)
end

-- Initialize SaveManager and InterfaceManager
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- Set the Default Tab
Window:SelectTab(1)

-- Notify that the script has loaded
Fluent:Notify({
    Title = "Compass",
    Content = "The script has been loaded.",
    Duration = 8
})

-- Load Autoload Config if available
SaveManager:LoadAutoloadConfig()
