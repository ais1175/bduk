![BDUK_THUMB](https://github.com/user-attachments/assets/0882c392-7569-4a14-83aa-224c0bbd99b8)

# BDUK — BOII Development UI Kit

**Alpha Release**  
> The current version is an alpha release. Expect improvements, additions, and the occasional breaking change. Most updates will be minor, but be ready to adapt if a bigger change lands.

Full docs: [docs.boii.dev](https://docs.boii.dev)

## What is BDUK?

Normally? **BOII Development UI Kit**  
When it’s working so well it feels like magic? **BIG D*CK UI KUNG-FU**  
When it refuses to cooperate? **Buggy Dumbass Useless Kit**

Tired of learning front-end UI code? Now you don’t have to.

BDUK is a full front-end toolkit built for scripting UIs entirely from Lua.  
No HTML, no CSS, no JavaScript knowledge required.

Think of a context menu resource — but bigger… a lot bigger.

## Who’s It For?

- People who **can’t code UI** — and don’t want to.
- Script authors who’d **rather build gameplay**.
- UI nerds (welcome too — but this one’s for the regular folks).
- You. Because you're done with context menus controlling everything.

## Why Use BDUK?

- **No Bloat** – Only includes what you actually use.
- **No Guesswork** – Modals, buttons, tooltips — they just work.
- **Reusability** – Build once, use everywhere.
- **Uniformity** – Get a consistent look across all your scripts.

## What’s Included?

### Main UI Frame
- **Header** – Branding, buttons, and maybe your nan's cat.
- **Footer** – Keybind hints, status rows, and other info.
- **Sidebar** – Optional menu with submenu support.
- **Content Area** – Your core UI.
- **Tooltip** – Hover-based tooltips (from our inventory UI).

### Components
- **Buttons** – With built-in modal injection.
- **Cards** – For stores, jobs, menus, and more.
- **Input Groups** – Expandable sections (clothing, tuning, etc).
- **Modal** – Selects, inputs, colours, and more.
- **Namecards** – Stylish character profile cards.
- **Notify** – Minimal in-UI notification system.

### Extras
- **Themes** – One file to customize colours, fonts, spacing, etc.
- **Layouts** *(coming soon)* – Premade store/panel setups.

## Quick Install

### Download
Get the **latest release** from the [Releases](https://github.com/boiidevelopment/bduk/releases/) page.

### Add the Resource
Drop the `bduk` folder into your `resources` directory.

### Add to `server.cfg`
```cfg
ensure bduk
```

### Restart or Start
Use the F8 console:
```
refresh; ensure bduk
```

## Configuration

Themes control most of BDUK’s look and feel.  
You can customize the default or create new ones entirely.

More on theming and advanced configuration:  
[docs.boii.dev](https://docs.boii.dev)

## Support

Need help? Found a bug? Need to vent about a bug that isn’t from this kit? Support is available through the BOII Development [Discord](https://discord.gg/MUckUyS5Kq).

**Support Hours: Mon–Fri, 10AM–10PM GMT**

Outside those hours? Pray to the debug gods or leave a message.
