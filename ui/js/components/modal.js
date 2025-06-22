/*
    This file is part of BDUK (BOII Development UI Kit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ BOII Development

    Support honest development — retain this credit. Don’t be that guy...
*/

import { Buttons } from "/ui/js/components/buttons.js"

/**
 * @class Modal
 * @description Renders a modal window with input fields and buttons.
 */
export class Modal {
    /**
     * @param {Object} config
     * @param {string} [config.title="Input Required"]
     * @param {Array<Object>} [config.options=[]]
     * @param {Array<Object>} [config.buttons=[]]
     * @param {string} [config.classes=""]
     */
    constructor({ title = "Input Required", options = [], buttons = [], classes = "" } = {}) {
        this.title = title;
        this.options = Array.isArray(options) ? options : Object.values(options);
        this.buttons = Array.isArray(buttons) ? buttons : Object.values(buttons);
        this.classes = classes;
    }

    /** @private @returns HTML for modal inputs  */
    get_input_html(opt) {
        const common = `id="${opt.id}" class="modal_input" placeholder="${opt.placeholder || ''}"`;

        if (opt.type === "select" && Array.isArray(opt.options)) {
            const opts = opt.options.map(o => `<div class="custom_option" data-value="${o.value}">${o.label}</div>`).join("");
            return `<div class="modal_field"><label for="${opt.id}">${opt.label || opt.id}</label><div class="modal_select_wrapper"><div class="modal_select" data-id="${opt.id}">${opt.options[0].label}</div><div class="modal_select_options">${opts}</div></div></div>`;
        }

        if (opt.type === "textarea") {
            return `<div class="modal_field"><label for="${opt.id}">${opt.label || opt.id}</label><textarea ${common}></textarea></div>`;
        }

        const attrs = [`type="${opt.type || 'text'}"`, common, opt.min !== undefined ? `min="${opt.min}"` : "", opt.max !== undefined ? `max="${opt.max}"` : ""].join(" ");
        return `<div class="modal_field"><label for="${opt.id}">${opt.label || opt.id}</label><input ${attrs.trim()} /></div>`;
    }

    /** @returns {string} Full HTML for the modal */
    get_html() {
        const inputs = this.options.map(opt => this.get_input_html(opt)).join("\n");
        const buttons = new Buttons({ buttons: this.buttons, classes: "modal_button_group" }).get_html();
        return `<div id="modal_container"><div class="modal ${this.classes}"><h2 class="modal_title">${this.title}</h2><div class="modal_inputs">${inputs}</div><div class="modal_actions">${buttons}</div></div></div>`.trim();
    }

    /** @returns {string} Full HTML for the modal */
    get_html() {
        const inputs = this.options.map(opt => this.get_input_html(opt)).join("\n");
        const buttons = new Buttons({ buttons: this.buttons, classes: "modal_button_group" }).get_html();
        return `<div id="modal_container"><div class="modal ${this.classes}"><h2 class="modal_title">${this.title}</h2><div class="modal_inputs">${inputs}</div><div class="modal_actions">${buttons}</div></div></div>`.trim();
    }

    /**
     * Appends the modal to DOM and binds events.
     * @param {string} [container="#ui_focus"]
     */
    append_to(container = "#ui_focus") {
        $(container).html(this.get_html()).addClass("active");

        $(".modal_select").off("click").on("click", function () {
            const $w = $(this).closest(".modal_select_wrapper");
            $(".modal_select_options").not($w.find(".modal_select_options")).hide();
            $w.find(".modal_select_options").toggle();
        });

        $(".modal_select_options .custom_option").off("click").on("click", function () {
            const val = $(this).data("value"), label = $(this).text(), $w = $(this).closest(".modal_select_wrapper");
            $w.find(".modal_select").text(label).data("value", val);
            $w.find(".modal_select_options").hide();
        });

        $(document).on("click", e => {
            if (!$(e.target).closest(".modal_select_wrapper").length) $(".modal_select_options").hide();
        });
    }

    /**
     * Static helper to quickly show a modal with.
     * @param {Object} config
     * @param {string} config.title
     * @param {Array<Object>} config.options
     * @param {Array<Object>} config.buttons
     */
    static show({ title = "Input Required", options = [], buttons = []}) {
        new Modal({ title, options, buttons }).append_to("#ui_focus");
    }
}
