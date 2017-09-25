function table.removevalue(tab, value)
    local idx = table.find(tab, value)
    if idx then
        table.remove(tab, idx)
    end
end

function table.find(tab, value)
    for k, v in pairs(tab) do
        if v == value then
            return k
        end
    end
    return nil
end

function table.copy(tab)
    local temp = {}
    for k, v in pairs(tab) do
        temp[k] = type(v) == "table" and table.copy(tab) or v
    end
    return temp
end
