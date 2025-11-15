--#region Button class

---@class (exact) Button
---@field key string The name of the key
Button = {}

---Constructs a new `Button` object
---@param buttonName string The name of the key
---@return Button button The new `Button` object
function Button:new(buttonName)
    local obj = {
        key = buttonName
    }
    ---@diagnostic disable-next-line: inject-field
    self.__index = self
    setmetatable(obj, self)
    return obj
end
---Holds the button down
function Button:hold()
    key.hold(self.key)
end

---Releases the button
function Button:release()
    key.release(self.key)
end
---Presses the button and then releases it on the next frame
function Button:tap()
    key.hold(self.key)
    concurrent.register_once(function() self:release() end, true)
end

--#endregion

--#region MouseHelper class

--- Helper class for moving the mouse
---@class (exact) MouseHelper
---@field sens number
MouseHelper = {}

function MouseHelper:new(sensitivity)
    local obj = {
        sens = sensitivity
    }
    ---@diagnostic disable-next-line: inject-field
    self.__index = self
    setmetatable(obj, self)
    return obj
end

function MouseHelper:rotate(x_deg, y_deg)
    -- TODO: complete this
end

--#endregion