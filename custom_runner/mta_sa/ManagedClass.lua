ManagedClass._generate      = function(class) class._instances = {} class._elements = {} class.class = class end
ManagedClass._cleanUp       = function(class, instance) for _, element in pairs(class._elements[instance] or {}) do destroyElement(element) end class._elements[instance] = {} end
ManagedClass._addElement    = function(class, instance, element) if not class._elements[instance] then class._elements[instance] = {} end table.insert(class._elements[instance], element) end
ManagedClass._removeElement = function(class, instance, element) table.removevalue(class._elements[instance], element) end

function ManagedClass:addElement(...)
    return self:getClass():_addElement(self, ...)
end

function ManagedClass:removeElement(...)
    return self:getClass():_removeElement(self, ...)
end