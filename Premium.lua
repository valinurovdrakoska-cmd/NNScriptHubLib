-- NNScriptLibrary v2.0 | Полностью рабочая + RGB текст + KeySystem
-- NNScriptHub Premium | Запуск
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/valinurovdrakoska-cmd/NNScriptHubLib/refs/heads/main/Library.lua"))()

local window = lib:Create({
    Title = "NNScriptHub Premium",
    KeySystem = true,
    Key = "NNPREMIUM-XAI2025"
})

-- Здесь добавляешь все свои фичи через window:Toggle, window:Button, window:Textbox

-- Пример:
window:Toggle("Fly", false, function(state)
    -- твой код
end)

window:Textbox("WalkSpeed", "Введите скорость", function(val)
    local n = tonumber(val)
    if n then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = n end
end)

-- и т.д.
