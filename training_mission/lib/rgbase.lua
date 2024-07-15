-- This is basically a copy of the MOOSE base class.
-- todo a chunk we are copyiong base but i want to be certain that i understand what base is doing
-- and everything before i just do it until then we use mooses's base.



RGBASE = {
    ClassName = "RGBase",
    ClassID = 0,
    Debug = debug,
    Scheduler = nil,
}

function RGBASE:New()
    local self = RGUTILS.DeepCopy(self)
    _ClassID = _ClassID + 1
    self.ClassID = ClassID
    return self
end
-- base inheret from moose.
function RGBASE:Inherit(child,Parent)
    local child = RGUTILS.DeepCopy(child)
    -- This is for "private" methods...
    -- When a __ is passed to a method as "self", the __index will search for the method on the public method list of the same object too!
    if rawget( Child, "__" ) then
        setmetatable( Child, { __index = Child.__ } )
        setmetatable( Child.__, { __index = Parent } )
      else
        setmetatable( Child, { __index = Parent } )
      end
end


--- This is the worker method to retrieve the Parent class.
-- Note that the Parent class must be passed to call the parent class method.
--
--     self:GetParent(self):ParentMethod()
--
--
-- @param #BASE self
-- @param #BASE Child This is the Child class from which the Parent class needs to be retrieved.
-- @param #BASE FromClass (Optional) The class from which to get the parent.
-- @return #BASE
function BASE:GetParent( Child, FromClass )

  local Parent
  -- BASE class has no parent
  if Child.ClassName == 'RGBase' then
    Parent = nil
  else

    -- self:E({FromClass = FromClass})
    -- self:E({Child = Child.ClassName})
    if FromClass then
      while (Child.ClassName ~= "RGBase" and Child.ClassName ~= FromClass.ClassName) do
        Child = getParent( Child )
        -- self:E({Child.ClassName})
      end
    end
    if Child.ClassName == 'RGBase' then
      Parent = nil
    else
      Parent = getParent( Child )
    end
  end
  -- self:E({Parent.ClassName})
  return Parent
end