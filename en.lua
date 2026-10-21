--// НАСТРОЙКА
local ONLY_ICE = true   -- true = сносить только лёд, false = сносить все опасные объекты

local ICE_KEYWORDS = {
    "ice", "frozen", "slippery", "slip",
    "лёд", "лед", "ледян", "гололёд", "гололед", "наледь", "айс"
}

local HAZARD_KEYWORDS = {
    "kill", "damage", "spike", "lava", "hazard", "death", "trap", "hurt", "void", "poison", "burn", "fire",
    "урон", "убий", "шип", "лава", "опасн", "смерт", "ловушк", "вред", "яд", "огонь"
}

local function nameMatches(name, list)
    local n = name:lower()
    for _, kw in ipairs(list) do
        if n:find(kw, 1, true) then return true end   -- plain find, без паттернов
    end
    return false
end

local function isTarget(inst)
    if not inst or not inst.Name then return false end
    if nameMatches(inst.Name, ICE_KEYWORDS) then return true end
    if not ONLY_ICE and nameMatches(inst.Name, HAZARD_KEYWORDS) then return true end
    return false
end

Tab:CreateButton({
    Name = ONLY_ICE and "Ice Deals No Damage" or "Remove All Hazards",
    Callback = function()
        local removed, names = 0, {}

        -- проверяем сам объект и его родителя (часто это Model/Folder "Лёд", "Ice1" и т.п.)
        local function targetOf(part)
            if isTarget(part) then return part end
            local parent = part.Parent
            if parent and parent ~= workspace and isTarget(parent) then return parent end
            return nil
        end

        local seen = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                local target = targetOf(obj)
                if target and not seen[target] then
                    seen[target] = true
                    removed += 1
                    if #names < 8 then table.insert(names, target.Name) end
                    target:Destroy()
                end
            end
        end

        Rayfield:Notify({
            Title = removed > 0 and "Success :)" or "Nothing Found",
            Content = removed > 0
                and ("Removed: " .. removed .. " (" .. table.concat(names, ", ") .. ")")
                or "Ничего не найдено — проверь список ключевых слов",
            Duration = 4,
            Image = 4483362458,
        })
    end,
})
