-- Developer: sbx320
-- License: MIT
-- Github Repos: https://github.com/sbx320/lua_utils
-- customized version in order to work with pure lua

--// classlib
--|| A library providing several tools to enhance OOP with Lua
--\\
DEBUG = DEBUG or false

function new(class, ...)
    assert(type(class) == "table", "first argument provided to new is not a table")

    -- DEBUG: Validate that we are not instantiating a class with pure virtual methods
    if DEBUG then
        for k, v in pairs(class) do
            assert(v ~= pure_virtual, "Attempted to instanciate a class with an unimplemented pure virtual method ("..tostring(k)..")")
        end
    end

    local instance = setmetatable( { },
        {
            __index = class;
            __super = { class };
            __newindex = class.__newindex;
            __call = class.__call;
            __len = class.__len;
            __unm = class.__unm;
            __add = class.__add;
            __sub = class.__sub;
            __mul = class.__mul;
            __div = class.__div;
            __pow = class.__pow;
            __concat = class.__concat;
        })

    -- Call derived constructors
    local callDerivedConstructor;
    callDerivedConstructor = function(self, instance, ...)
        for k, v in pairs(self) do
            if rawget(v, "virtual_constructor") then
                rawget(v, "virtual_constructor")(instance, ...)
            end
            local s = super(v)
            if s then callDerivedConstructor(s, instance, ...) end
        end
    end

    callDerivedConstructor(super(class), instance, ...)

    -- Call constructor
    if rawget(class, "constructor") then
        rawget(class, "constructor")(instance, ...)
    end
    instance.constructor = false

    return instance
end

function delete(self, ...)
    if not self then error(debug.traceback()) end
    if self.destructor then --if rawget(self, "destructor") then
        self:destructor(...)
    end

    -- Prevent the destructor to be called twice
    self.destructor = false

    local callDerivedDestructor;
    callDerivedDestructor = function(parentClasses, instance, ...)
        for k, v in pairs(parentClasses) do
            if rawget(v, "virtual_destructor") then
                rawget(v, "virtual_destructor")(instance, ...)
            end
            local s = super(v)
            if s then callDerivedDestructor(s, instance, ...) end
        end
    end
    callDerivedDestructor(super(self), self, ...)
end

function super(self)
    if isElement(self) then
        if not oop.elementInfo[self] then
            return {}
        end
        self = oop.elementInfo[self]
    end
    local metatable = getmetatable(self)
    if metatable then return metatable.__super
    else
        return {}
    end
end

function inherit(from, what)
    if not from then error(debug.traceback()) end
    assert(from, "Attempt to inherit a nil table value")
    if not what then
        local classt = setmetatable({}, { __index = _inheritIndex, __super = { from } })
        if from.onInherit then
            from:onInherit(classt)
        end
        return classt
    end

    local metatable = getmetatable(what) or {}
    local oldsuper = metatable and metatable.__super or {}
    table.insert(oldsuper, 1, from)
    metatable.__super = oldsuper
    metatable.__index = _inheritIndex

    -- Inherit __call
    for k, v in ipairs(metatable.__super) do
        if v.__call then
            metatable.__call = v.__call
            break
        end
    end

    return setmetatable(what, metatable)
end

function _inheritIndex(self, key)
    for k, v in pairs(super(self) or {}) do
        if v[key] then return v[key] end
    end
    return nil
end

function instanceof(self, class, direct)
    for k, v in pairs(super(self)) do
        if v == class then return true end
    end

    if direct then return false end

    local check = false
    -- Check if any of 'self's base classes is inheriting from 'class'
    for k, v in pairs(super(self)) do
        check = instanceof(v, class, false)
    end
    return check
end

function pure_virtual()
    outputDebugString(debug.traceback())
    error("Function implementation missing")
end

function bind(func, ...)
    if not func then
        if DEBUG then
            outputConsole(debug.traceback())
            if outputServerLog then
                outputServerLog(debug.traceback())
            end
        end
        error("Bad function pointer @ bind. See console for more details")
    end

    local boundParams = {...}
    return
        function(...)
            local params = {}
            local boundParamSize = select("#", unpack(boundParams))
            for i = 1, boundParamSize do
                params[i] = boundParams[i]
            end

            local funcParams = {...}
            for i = 1, select("#", ...) do
                params[boundParamSize + i] = funcParams[i]
            end
            return func(unpack(params))
        end
end

function load(class, ...)
    assert(type(class) == "table", "first argument provided to load is not a table")
    local instance = setmetatable( { },
        {
            __index = class;
            __super = { class };
            __newindex = class.__newindex;
            __call = class.__call;
        })

    -- Call load
    if rawget(class, "load") then
        rawget(class, "load")(instance, ...)
    end
    instance.load = false

    return instance
end