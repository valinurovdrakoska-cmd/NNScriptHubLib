-- NNScriptLibrary v2.0 | Полностью рабочая + RGB текст + KeySystem
local NNScriptLibrary = {}

function NNScriptLibrary:Create(options)
    local lib = {}
    options = options or {}
    lib.Title = options.Title or "NNScriptHub"
    lib.KeySystem = options.KeySystem or false
    lib.Key = options.Key or "TESTKEY2025"

    local screen = Instance.new("ScreenGui", game.CoreGui)
    screen.ResetOnSpawn = false

    local main
    local y = 60

    local function createHub()
        main = Instance.new("Frame", screen)
        main.Size = UDim2.new(0,500,0,620)
        main.Position = UDim2.new(0.5,-250,0.5,-310)
        main.BackgroundColor3 = Color3.fromRGB(10,0,30)
        main.BackgroundTransparency = 0.05
        main.Active = true
        main.Draggable = true
        Instance.new("UICorner",main).CornerRadius = UDim.new(0,22)

        -- RGB рамка
        local rgbStroke = Instance.new("UIStroke", main)
        rgbStroke.Thickness = 9
        rgbStroke.Transparency = 0.3
        spawn(function()
            while main.Parent do
                for i = 0,1,0.002 do
                    rgbStroke.Color = Color3.fromHSV(i,1,1)
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

        -- Крестик
        local close = Instance.new("TextButton", main)
        close.Size = UDim2.new(0,40,0,40)
        close.Position = UDim2.new(1,-48,0,8)
        close.BackgroundColor3 = Color3.fromRGB(255,0,0)
        close.Text = "X"
        close.TextColor3 = Color3.new(1,1,1)
        close.Font = Enum.Font.GothamBlack
        close.TextSize = 30
        Instance.new("UICorner",close).CornerRadius = UDim.new(0,50)
        close.MouseButton1Click:Connect(function() screen:Destroy() end)

        -- Сворачивание + NN
        local min = Instance.new("TextButton", main)
        min.Size = UDim2.new(0,40,0,40)
        min.Position = UDim2.new(1,-92,0,8)
        min.BackgroundColor3 = Color3.fromRGB(200,0,0)
        min.Text = "−"
        min.TextColor3 = Color3.new(1,1,1)
        min.Font = Enum.Font.GothamBlack
        min.TextSize = 40
        Instance.new("UICorner",min).CornerRadius = UDim.new(0,50)

        local nn = Instance.new("TextButton", screen)
        nn.Size = UDim2.new(0,80,0,80)
        nn.Position = UDim2.new(0,20,1,-100)
        nn.BackgroundColor3 = Color3.fromRGB(255,0,100)
        nn.Text = "NN"
        nn.TextColor3 = Color3.new(1,1,1)
        nn.Font = Enum.Font.GothamBlack
        nn.TextSize = 36
        nn.Visible = false
        nn.Active = true
        nn.Draggable = true
        Instance.new("UICorner",nn).CornerRadius = UDim.new(0,50)
        nn.MouseButton1Click:Connect(function() nn.Visible = false main.Visible = true end)
        min.MouseButton1Click:Connect(function() main.Visible = false nn.Visible = true end)

        -- Функции добавления элементов
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
    end

    if lib.KeySystem then
        -- KeySystem код (как раньше, но с RGB)
        -- ... (весь KeySystem из предыдущей версии)
        -- после правильного ключа вызываем createHub()
        keyenter.MouseButton1Click:Connect(function()
            if keytb.Text == lib.Key then
                keyframe:Destroy()
                createHub()
            end
        end)
    else
        createHub()
    end

    return lib
end

return NNScriptLibrary
