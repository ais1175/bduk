--[[
    This file is part of BDUK (BOII Development UI Kit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ BOII Development

    Support honest development — retain this credit. Don’t be that guy...
]]

bduk = setmetatable({}, { __index = _G })

bduk.debug_enabled = true
bduk.debug_colours = {
    reset = "^7",
    debug = "^6",
    info = "^5",
    success = "^2",
    warn = "^3",
    error = "^8",
    critical = "^1",
    dev = "^9"
}
bduk.is_server = IsDuplicityVersion()
bduk.registered_functions = {}

--- @section Utility Functions

--- Registers a function under a unique key for callbacks.
--- @param label string: The unique key to associate with the function.
--- @param func function: The function to register.
function bduk.register_function(label, func)
    bduk.registered_functions[label] = func
end

--- Calls a registered function by its label.
--- @param label string: The key associated with the function.
--- @return The result of the function, or false if not found.
function bduk.call_registered_function(label)
    if not label then bduk.log("error", "function label is required") return false end

    local func = bduk.registered_functions[label]
    if not func then bduk.log("error", ("function with label %s not found"):format(label)) return false end

    return bduk.registered_functions[label]()
end

--- Recursively sanitizes a UI config by replacing functions with labels and storing them
--- @param data table: The original UI configuration table
--- @param path string: Current traversal path (used to generate unique labels)
--- @return table: A version of the UI config safe to send to JS
function bduk.sanitize_ui(data, path)
    path = path or "root"
    local out = {}

    for k, v in pairs(data) do
        local p = ("%s_%s"):format(path, tostring(k)):gsub("[^%w_]", "")

        if (k == "on_click" or k == "on_keypress" or k == "on_increment" or k == "on_decrement") then
            bduk.register_function(p, v)
            out.action = p
        elseif type(v) == "table" then
            out[k] = bduk.sanitize_ui(v, p)
        else
            out[k] = v
        end
    end

    return out
end

--- Takes a full UI config and sanitizes it for sending to NUI
--- @param config table
--- @return table
function bduk.build_ui(config)
    return bduk.sanitize_ui(config, "ui")
end

--- Copied from BDUL debugging functions to keep BDUK standalone.
--- Returns the current timestamp as a formatted string.
--- @return string: Formatted time (YYYY-MM-DD HH:MM:SS)
function bduk.get_current_time()
    if bduk.is_server then return os.date("%Y-%m-%d %H:%M:%S") end
    if GetLocalTime then
        local y, m, d, h, min, s = GetLocalTime()
        return string.format("%04d-%02d-%02d %02d:%02d:%02d", y, m, d, h, min, s)
    end
    return "0000-00-00 00:00:00"
end

--- Copied from BDUL debugging functions to keep BDUK standalone.
--- Prints a formatted debug message to the console.
--- @param level string: One of "debug", "info", "success", "warn", "error", "critical", "dev".
--- @param message string: Pre-formatted message to display.
function bduk.log(level, message)
    if not bduk.debug_enabled then return end

    local clr = bduk.debug_colours[level] or "^7"
    local time = bduk.get_current_time()

    print(("%s[%s] [bdtk] [%s]:^7 %s"):format(clr, time, level:upper(), message))
end