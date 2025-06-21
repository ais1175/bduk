/*
    This file is part of BDUK (BOII Development UI Kit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ BOII Development

    Support honest development — retain this credit. Don’t be that guy...
*/

import { Builder } from "/ui/js/builder.js";
import { Notify } from "/ui/js/components/notify.js";

/**
 * Notification instance
 * Will move settings to somewhere toggleable at some point?.. maybe..
 * @type {Notify}
 */
const notify = new Notify({
    position: "right-center",
    fill_direction: "up"
});

/**
 * Registered message handlers for NUI callbacks.
 * @type {Object<string, Function>}
 */
const handlers = {};

/**
 * Builds a UI from a provided config payload.
 * @function handlers.build_ui
 * @param {Object} data - Message data object.
 * @param {Object} data.payload - The UI configuration to render.
 */
handlers.build_ui = (data) => {
    if (!data.payload) {
        console.warn("No UI data provided");
        return;
    }

    if (window.bduk_instance && typeof window.bduk_instance.destroy === "function") {
        window.bduk_instance.destroy();
        window.bduk_instance = null;
    }

    const builder = new Builder(data.payload);
    window.bduk_instance = builder;
};

/**
 * Destroys the currently active UI instance, if any.
 * @function handlers.close_ui
 */
handlers.close_ui = () => {
    if (window.bduk_instance && typeof window.bduk_instance.destroy === "function") {
        window.bduk_instance.destroy();
        window.bduk_instance = null;
    }
};

/**
 * Displays a notification using the Notify component.
 * @function handlers.notify
 * @param {Object} data - Message data object.
 * @param {Object} data.payload - Notification content/config.
 */
handlers.notify = (data) => {
    if (!data || !data.payload) {
        console.warn("[Notify] Missing payload.");
        return;
    }

    notify.show(data.payload);
};

/**
 * Global message listener for all NUI messages.
 * Routes each message to its corresponding handler.
 */
window.addEventListener("message", (event) => {
    const { func } = event.data;
    const handler = handlers[func];

    if (typeof handler !== "function") {
        console.warn(`Handler missing: ${func}`);
        return;
    }

    handler(event.data);
});
