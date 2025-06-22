--[[
    This file is part of BDUK (BOII Development UI Kit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ BOII Development

    Support honest development — retain this credit. Don’t be that guy...
]]

if bduk.is_server then

    --- Sends a notification to a specific player client.
    --- @param source number: The player source ID to send the notification to.
    --- @param opts table: The notification configuration.
    exports("notify", function(source, opts)
        if not source or not opts then bduk.log("error", "notify: Invalid params provided.") return end

        bduk.log("info", ("notify: Sending to [%s] with %s"):format(source, json.encode(opts)))
        TriggerClientEvent("bduk:notify", source, opts)
    end)

    --- Builds a UI on the specified client.
    --- @param source number: The player source ID to send the UI to.
    --- @param ui table: The UI configuration table.
    exports("build", function(source, ui)
        if not source or not ui then bduk.log("error", "build: Invalid params provided.") return end

        bduk.log("info", ("build: Sending UI to [%s]"):format(source))
        TriggerClientEvent("bduk:build", source, ui)
    end)

else
    --- @section Variables

    --- Tracks if the UI is currently active on the client.
    --- @type boolean
    local ui_active = false

    --- @section Functions

    --- Sends a notification to the NUI layer.
    --- @param opts table: Notification options (type, message, header, icon, duration, etc.)
    local function notify(opts)
        if not opts then bduk.log("error", "notify: Options missing.") return end

        bduk.log("success", ("notify: Dispatching %s"):format(json.encode(opts)))
        SendNUIMessage({
            func = "notify",
            payload = opts
        })
    end

    --- Exported client-side function to send a notification.
    --- @param opts table: Notification configuration table.
    exports("notify", notify)

    --- Sends a full UI to the NUI layer and sets focus.
    --- @param ui table: UI config table to build.
    local function build(ui)
        if not ui then bduk.log("error", "build: UI config missing.") return end

        local safe_ui = bduk.build_ui(ui)
        if not safe_ui then bduk.log("error", "build: UI config wasnt returned after sanitize.") return end
        bduk.log("info", "build: Building UI and setting NUI focus.")
        SetNuiFocus(not IsNuiFocused(), not IsNuiFocused())
        SendNUIMessage({ 
            func = "build_ui",
            payload = safe_ui 
        })
    end

    --- Exported client-side function to build a UI.
    --- @param ui table: Full UI configuration.
    exports("build", build)

    --- @section Events

    --- Receives and displays a notification triggered by the server.
    --- @param opts table: Notification options.
    RegisterNetEvent("bduk:notify", function(opts)
        bduk.log("dev", ("Event triggered: notify %s"):format(json.encode(opts)))
        notify(opts)
    end)

    --- Receives and builds a UI triggered by the server.
    --- @param ui table: UI configuration.
    RegisterNetEvent("bduk:build", function(ui)
        bduk.log("dev", "Event triggered: build UI")
        build(ui)
    end)

    --- @section NUI Callbacks

    --- Removes focus from the NUI.
    --- Triggered by NUI when UI needs to close.
    RegisterNUICallback("nui:remove_focus", function()
        bduk.log("debug", "nui:remove_focus - Focus cleared.")
        SetNuiFocus(false, false)
    end)

    --- Handles generic action callbacks sent from the UI.
    --- @param data table: Data from the NUI containing the action to perform.
    --- @param cb function: Callback to signal response.
    RegisterNUICallback("nui:handler", function(data, cb)
        bduk.log("debug", ("nui:handler invoked with: %s"):format(json.encode(data)))
        if not data or not data.action then
            bduk.log("error", "NUI handler: Missing action field.")
            if cb then cb(false) end
            return
        end
        
        local success, result = pcall(bduk.call_registered_function, data.action, data)

        if not success then
            bduk.log("error", ("NUI handler: Function call failed - %s"):format(result))
        end

        if data.should_close then
            SetNuiFocus(false, false)
        end

        if cb then cb(true) end
    end)

end
