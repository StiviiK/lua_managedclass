ManagedClass = {}
ManagedClass._generate      = function(class) class._instances = {} class.class = class end
ManagedClass._add           = function(class, instance) table.insert(class._instances, instance) return instance end
ManagedClass._remove        = function(class, instance) table.removevalue(class._instances, instance) return instance end
ManagedClass._deleteAll     = function(class, ...)  for _, instance in ipairs(class._instances) do delete(instance, true, ...) class._cleanUp(class, instance) end class._instances = {} end
ManagedClass._cleanUp       = pure_virtual -- Implement as custom_runner

ManagedClass.constructor = pure_virtual
ManagedClass.destructor = pure_virtual

function ManagedClass:onInherit(derivedClass)
    derivedClass.super = self
    derivedClass:_generate()
end

function ManagedClass:new(...)
    return self:_add(new(self, ...))
end

function ManagedClass:virtual_destructor(auto, ...)
    if not auto then -- TODO: Improve this!
        self:getClass():_remove(self)
    end
end

function ManagedClass:getClass()
    return self.class
end

function ManagedClass:deleteAll(...)
    self:getClass():_deleteAll(...)
end

function ManagedClass:getInstances()
    return self:getClass()._instances
end