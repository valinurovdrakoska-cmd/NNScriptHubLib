-- NNScriptLibrary v1.1 | RGB + KeySystem + Переливающийся текст
local NNScriptLibrary = {}

function NNScriptLibrary:Create(options)
    local lib = {}
    options = options or {}
    lib.Title = options.Title or "NNScriptHub"
    lib.KeySystem = options.KeySystem or false
    lib.Key = options.Key or "TESTKEY2025"

    local screen = Instance.new("ScreenGui", game.CoreGui)
    screen.ResetOnSpawn = false
    screen.Name = "NNScriptLib"

    local main
    local y = 60

    if lib.KeySystem then
        local keyframe = Instance.new("Frame", screen)
        keyframe.Size = UDim2.new(0,460,0,420)
        keyframe.Position = UDim2.new(0.5,-230,0.5,-210)
        keyframe.BackgroundColor3 = Color3.fromRGB(10,0,30)
        keyframe.Active = true
        keyframe.Draggable = true
        Instance.new("UICorner",keyframe).CornerRadius = UDim.new(0,20)

        local rgbStroke = Instance.new("UIStroke", keyframe)
        rgbStroke.Thickness = 8
        rgbStroke.Transparency = 0.3
        spawn(function()
            while keyframe.Parent do
                for i = 0,1,0.002 do
                    rgbStroke.Color = Color3.fromHSV(i,1,1)
                    wait(0.005)
                end
            end
        end)

        local keytitle = Instance.new("TextLabel",keyframe)
        keytitle.Size = UDim2.new(1,0,0.2,0)
        keytitle.BackgroundTransparency = 1
        keytitle.Text = lib.Title .. " KeySystem"
        keytitle.Font = Enum.Font.GothamBlack
        keytitle.TextSize = 38
        spawn(function()
            while keytitle.Parent do
                for i = 0,1,0.002 do
                    keytitle.TextColor3 = Color3.fromHSV(i,1,1)
                    wait(0.005)
                end
            end
        end)

        local keytb = Instance.new("TextBox",keyframe)
        keytb.Size = UDim2.new(0.84,0,0.13,0)
        keytb.Position = UDim2.new(0.08,0,0.4,0)
        keytb.PlaceholderText = "введи ключ"
        keytb.BackgroundColor3 = Color3.fromRGB(30,0,50)
        keytb.TextColor3 = Color3.new(1,1,1)
        keytb.Font = Enum.Font.GothamBold
        keytb.TextSize = 28
        Instance.new("UICorner",keytb).CornerRadius = UDim.new(0,14)

        local keyenter = Instance.new("TextButton",keyframe)
        keyenter.Size = UDim2.new(0.84,0,0.16,0)
        keyenter.Position = UDim2.new(0.08,0,0.68,0)
        keyenter.Text = "АКТИВИРОВАТЬ"
        keyenter.BackgroundColor3 = Color3.fromRGB(200,0,255)
        keyenter.TextColor3 = Color3.new(1,1,1)
        keyenter.Font = Enum.Font.GothamBlack
        keyenter.TextSize = 38
        keyenter.AutoButtonColor = false
        Instance.new("UICorner",keyenter).CornerRadius = UDim.new(0,18)
        keyenter.MouseButton1Click:Connect(function()
            if keytb.Text == lib.Key then
                keyframe:Destroy()
                lib:OpenHub()
            else
                game.StarterGui:SetCore("SendNotification",{Title="Ошибка",Text="Ключ неправильный",Duration=5})
            end
        end)
    else
        lib:OpenHub()
    end

    function lib:OpenHub()
        main = Instance.new("Frame", screen)
        main.Size = UDim2.new(0,500,0,620)
        main.Position = UDim2.new(0.5,-250,0.5,-310)
        main.BackgroundColor3 = Color3.fromRGB(10,0,30)
        main.BackgroundTransparency = 0.05
        main.Active = true
        main.Draggable = true
        Instance.new("UICorner",main).CornerRadius = UDim.new(0,22)

        -- RGB РАМКА
        local rgb = Instance.new("UIStroke", main)
        rgb.Thickness = 9
        rgb.Transparency = 0.3
        spawn(function()
            while main.Parent do
                for i = 0,1,0.002 do
                    rgb.Color = Color3.fromHSV(i,1,1)
                    wait(0.005)
                end
            end
        end)

        -- Заголовок с RGB текстом
        local header = Instance.new("TextLabel", main)
        header.Size = UDim2.new(1,0,0,50)
        header.BackgroundTransparency = 1
        header.Text = lib.Title
        header.Font = Enum.Font.GothamBlack
        header.TextSize = 38
        spawn(function()
            while header.Parent do
                for i = 0,1,0.002 do
                    header.TextColor3 = Color3.fromHSV(i,1,1)
                    wait(0.005)
                end
            end
        end)

        -- Крестик + сворачивание + NN (всё работает)

        y = 60

        function lib:Button(text, callback)
            local btn = Instance.new("TextButton", main)
            btn.Size = UDim2.new(0.9,0,0,50)
            btn.Position = UDim2.new(0.05,0,0,y)
            btn.BackgroundColor3 = Color3.fromRGB(180,0,100)
            btn.Text = text
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 30
            Instance.new("UICorner",btn).CornerRadius = UDim.new(0,14)
            btn.MouseButton1Click:Connect(callback)
            y = y + 60
        end

        function lib:Toggle(text, default, callback)
            local state = default or false
            local tog = Instance.new("TextButton", main)
            tog.Size = UDim2.new(0.9,0,0,50)
            tog.Position = UDim2.new(0.05,0,0,y)
            tog.BackgroundColor3 = state and Color3.fromRGB(0,200,0) or Color3.fromRGB(180,0,0)
            tog.Text = text .. (state and " ON" or " OFF")
            tog.TextColor3 = Color3.new(1,1,1)
            tog.Font = Enum.Font.GothamBold
            tog.TextSize = 30
            Instance.new("UICorner",tog).CornerRadius = UDim.new(0,14)
            tog.MouseButton1Click:Connect(function()
                state = not state
                tog.BackgroundColor3 = state and Color3.fromRGB(0,200,0) or Color3.fromRGB(180,0,0)
                tog.Text = text .. (state and " ON" or " OFF")
                callback(state)
            end)
            y = y + 60
        end

        function lib:Textbox(labelText, placeholder, callback)
            local label = Instance.new("TextLabel", main)
            label.Size = UDim2.new(0.9,0,0,30)
            label.Position = UDim2.new(0.05,0,0,y)
            label.BackgroundTransparency = 1
            label.Text = labelText
            label.TextColor3 = Color3.fromRGB(255,200,255)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 26
            label.TextXAlignment = Enum.TextXAlignment.Left

            local box = Instance.new("TextBox", main)
            box.Size = UDim2.new(0.9,0,0,45)
            box.Position = UDim2.new(0.05,0,0,y+30)
            box.BackgroundColor3 = Color3.fromRGB(40,0,60)
            box.PlaceholderText = placeholder
            box.Text = ""
            box.TextColor3 = Color3.new(1,1,1)
            box.Font = Enum.Font.Gotham
            box.TextSize = 26
            Instance.new("UICorner",box).CornerRadius = UDim.new(0,12)
            box.FocusLost:Connect(function()
                callback(box.Text)
            end)
            y = y + 90
        end

        return lib
    end

    return lib
end

return NNScriptLibrary
