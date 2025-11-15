---@meta

--#region concurrent

---Contains functions used to register / unregister a concurrent function
---@class (exact) concurrent
---@field register function
---@field register_once function
---@field unregister function
concurrent = {}

---@alias register_uid register_uid

---Registers a function to run along with the main script <br/>
---This will also run the function for the current frame if `post_update` is `false`
---@param func function The function to run
---@param post_update? boolean default: `false`. `true` would make the function run after frame advancing, `false` to make it run before frame advancing
---@param ...? any Default arguments to pass to the function.<ul><li>You don't have to put anything if your function needs nothing.</li><li>If you don't match the number of arguments as same as the function signature, it will throw an exception usually</li></ul>
---@return register_uid register_uid identifier for that registered concurrent function
function concurrent.register(func, post_update, ...) end

---Registers a function to run along with the main script, but will only run once
---This will also run the function for the current frame if `post_update` is `false`
---@param func function The function to run
---@param post_update? boolean default: `false`. `true` would make the function run after frame advancing, `false` to make it run before frame advancing
---@param ...? any Default arguments to pass to the function.<ul><li>You don't have to put anything if your function needs nothing.</li><li>If you don't match the number of arguments as same as the function signature, it will throw an exception usually</li></ul>
---@return register_uid register_uid identifier for that registered concurrent function
function concurrent.register_once(func, post_update, ...) end

---Unregisters a concurrently running function
---@param register_uid register_uid
function concurrent.unregister(register_uid) end

--#endregion

--#region key

---Used for manipulating the keyboard
---@class (exact) key
---@field hold function
---@field release function
---@field clear function
key = {}

---Holds a key down
---@param key string The key to hold down.<ul><li>The names are values from [here](https://docs.unity3d.com/ScriptReference/KeyCode.html) or [here](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.8/api/UnityEngine.InputSystem.Key.html?q=Key) or [here](https://docs.unity3d.com/6000.0/Documentation/Manual/class-InputManager.html)</li><li>Guessing what the key is called usually works</li></ul>
function key.hold(key) end

---Releases a key
---@param key string The key to release.<ul><li>The names are values from [here](https://docs.unity3d.com/ScriptReference/KeyCode.html) or [here](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.8/api/UnityEngine.InputSystem.Key.html?q=Key) or [here](https://docs.unity3d.com/6000.0/Documentation/Manual/class-InputManager.html)</li><li>Guessing what the key is called usually works</li></ul>
function key.release(key) end

---Clears all keys that are currently held down
function key.clear() end

--#endregion

--#region mouse

---Used for manipulating the mouse
---@class (exact) mouse
---@field left function
---@field middle function
---@field right function
---@field move function
---@field move_rel function
---@field set_scroll function
mouse = {}

---Holds the left mouse button
---@param hold? boolean default: `true` <br> `true` to hold left click, `false` to release
function mouse.left(hold) end

---Holds the middle mouse button
---@param hold? boolean default: `true` <br> `true` to hold left click, `false` to release
function mouse.middle(hold) end

---Holds the right mouse button
---@param hold? boolean default: `true` <br> `true` to hold right click, `false` to release
function mouse.right(hold) end


---Moves the mouse to a position
---@param x number The x position to move to
---@param y number The y position to move to
function mouse.move(x, y) end

---Moves the mouse to a position relative to the current position
---@param x number The x offset to move to
---@param y number The y offset to move to
function move_rel(x, y) end

---Sets the scroll speed
---@param x number The x scroll speed
---@param y number The y scroll speed
function mouse.set_scroll(x, y) end

--#endregion

--#region controller

---Used for manipulating the controller<br>
---**NOTE**: Some of this will be eventually replaced after better legacy input system support for unity
---@class (exact) controller
---@field x_axis function
---@field y_axis function
---@field axis function
---@field hold function
---@field release function
---@field add_player function
controller = {}

---Sets the x axis of the controller
---@param value number a value ranging from `-1` to `1` to be used for the x axis
function controller.x_axis(value) end

---Sets the y axis of the controller
---@param value number a value ranging from `-1` to `1` to be used for the y axis
function controller.y_axis(value) end

---Sets the value of an axis
---@param axis integer The axis to control, ranging from `1` to `28` (inclusive)
---@param value number The value to set the axis to, ranging from `-1` to `1`
function controller.axis(axis, value) end

---Holds a controller button down
---@param button integer The button to control, ranging from `0` to `19`
function controller.hold(button) end

---Releases a controller button
---@param button integer
function controller.release(button) end

---@alias player controller

---Adds a controller to the game
---@return player player The added controller
function controller.add_player() end

--#endregion

--#region env

---@alias UpdateType
---| "Update" Stops before `MonoBehaviour.Update`
---| "FixedUpdate" Stops before `MonoBehaviour.FixedUpdate`
---| "Both" Stops both before `MonoBehaviour.Update` and `MonoBehaviour.FixedUpdate`

---Game environment, used for changing the game environment
---@class (exact) env 
---@field fps number The current FPS of the game, you can read / write to this<br>**NOTE**: Setting this will apply the change on the next frame (so after the next `movie.frame_advance` call)
---@field frametime number The current frametime of the game, you can read / write to this<br>**NOTE**: Setting this will apply the change on the next frame (so after the next `movie.frame_advance` call)
---@field update_type function
env = {}

---The type of update to use on frame advance<br>Same as `MOVIE_CONFIG.update_type`, but lets you change this at any point in time
---@param type UpdateType The update type to set the game to
function env.update_type(type) end

--#endregion

--#region movie

---Used to control movie playback
---@class (exact) movie
---@field playback_speed function
---@field frame_advance function
---@field no_refresh function
---@field start_capture function
---@field stop_capture function
movie = {}

---Sets the current playback speed of the movie
---@param speed_multiplier number The speed multiplier to set the playback speed to. Setting this to 0 will run the game as fast as possible, setting this to 1 will run the game at 1x speed, setting this to 0.5 will run the game at 0.5x speed, etc
function movie.playback_speed(speed_multiplier) end

---Frame advances the movie by `count` frames<br>Technically, it's an alias for `coroutine.yield()`
---@param count? integer Default: `1`<br> The number of frames to frame advance
function movie.frame_advance(count) end


---Enables no-refresh by disabling rendering<br>
---#### Note:
--- - Results vary on if the game speeds up or not for your PC
--- - Has (some) safety to prevent game behaviour from changing, meaning no_refresh does nothing if safety is enabled
---@param enable boolean `true` enables no-refresh and stops game rendering, `false` disables no-refresh and resumes game rendering
function movie.no_refresh(enable) end

---@alias movieCaptureTable { fps: number, width: number, height: number, path: string} 

---Starts capturing the movie<br>
---You don't need to call `movie.stop_capture()` at the end of the script, 
---it will automatically stop the capture when the script ends
---@param args? movieCaptureTable A table of arguments to pass to the capture<ul><li>`fps` - Default: `60`. The FPS to capture the movie at.</li><li>`width` - Default: `1920`. The width of the rendered movie. Must be even</li><li>`height` - Default: `1080`. The height of the rendered movie. Must be even</li><li>`path` - Default: `"output.mp4"`. The path to save the movie to. Accepts relative path from the game directory, or an absolute path</li></ul>
function movie.start_capture(args) end

---Stops capturing the movie
function movie.stop_capture() end

--#endregion

--#region unity

---Provides read only access to unity side
---@class (exact) unity
---@field find_objects_by_type function
unity = {}

---Finds unity objects by type
---@param type_name string The C# type name of the object to find. It would be ideal to include the namespace, but should be fine with just the type name
---@return any[] UnityObjects The found unity objects
---@return nil None No objects were found
function unity.find_objects_by_type(type_name) end

--#endregion
