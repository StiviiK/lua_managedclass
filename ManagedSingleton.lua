ManagedSingleton = inherit(ManagedClass)
ManagedSingleton._getSingleton  = function(class) return class.instances[1] end

function ManagedSingleton:new(...)
    self.new = function() end
    return ManagedClass.new(self, ...)
end

function ManagedSingleton:getSingleton(...)
    local instance = self:getClass():_getSingleton()
    if not instance then
        return self:getClass():new(...)
    end
    return instance
end