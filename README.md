# 🚨 ELS for FiveM with [WM-ServerSirens](https://github.com/Walsheyy/WMServerSirens)

This project integrates the Emergency Lighting System (ELS) for FiveM, using server-side sirens powered by [WM-ServerSirens](https://github.com/Walsheyy/WMServerSirens).

---

## ⚠️ Note

* This script **does not support horn customization by default.**
  → If you want to customize the horn, please check the [wiki guide](https://github.com/tah5882/ELS-FiveM/wiki/How-to-customize-your-horn).

---

## ✅ Requirements

* [WM-ServerSirens](https://github.com/Walsheyy/WMServerSirens)
* ELS-compatible vehicle and corresponding `car_name.xml`

---

## 🎮 Default Controls

👉 Full controls overview here:
[📖 Controls Wiki](https://github.com/MrDaGree/ELS-FiveM/wiki/Controls)

---

## 📦 Installation Guide

1. Clone this repository or download the [latest release](../../releases/latest).

   > Note: When cloning, use a folder name like `[ELS]` (e.g., `git clone https://github.com/tah5882/ELS-FiveM [ELS]`) inside your `resources` directory.
2. Place the folder inside your server’s `resources` directory.
3. Create a file named `vcf.lua` and copy the contents of `vcf._default_.lua` into it.

   > ⚠️ Do **not** delete the original `vcf._default_.lua` file.
4. Modify `vcf.lua` as needed.
5. Add any VCF files into the `vcf` folder so they can be detected.
6. Enjoy!

---

## ⚙️ Convars (Server Configuration Variables)

| Convar              | Type    | Description                                                                                        | Example                       | Default |
| ------------------- | ------- | -------------------------------------------------------------------------------------------------- | ----------------------------- | ------- |
| `els_outputLoading` | boolean | Outputs the loaded vehicles defined in `vcf.lua` when the server starts.                           | `setr els_outputLoading true` | false   |
| `els_debug`         | boolean | Enables debug info printing on both client and server sides.                                       | `setr els_debug true`         | false   |
| `els_developer`     | boolean | Enables developer features that may break ELS for clients; use only if you know what you’re doing. | `setr els_developer true`     | false   |
