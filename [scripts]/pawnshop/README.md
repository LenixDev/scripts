# PawnShop Script

## 📖 Overview
The PawnShop script allows players to manage and operate their own pawn shop within the game. This script is designed to be user-friendly and includes essential features for managing items, transactions, and more.

## 📋 Features
- **Own the Pawn Shop:** Easily manage and own your own pawn shop.
- **Sell Any Item:** Ability to sell any item you want, whether it's a weapon, equipment, or anything else.
- **Restrict Any Item:** Complete control over the items available for sale, allowing you to restrict unwanted items.
- **Includes Logs:** The script includes all necessary logs to facilitate management.
- **Supports Two Languages:** The script supports both Arabic and English, making it suitable for a wide audience.
- **Easy to Use and Modify:** Simple and user-friendly design, you can modify it according to your needs without complications.
- **Supports QBCORE:** Seamlessly integrates with the QBCORE system, enhancing game performance.
- **Discord Support:** The script features event logging to Discord, allowing you to track all business operations.
- **24/7 Technical Support:** We offer around-the-clock technical support to ensure an optimal user experience.
- **Built from Scratch:** The script has been developed entirely from scratch to ensure high quality and performance.
- **Zinez dev :** https://discord.gg/pkeKNN8GRX
## 🛠️ Requirements
- `dependencies { 'ox_lib' }`

## 💲 Pricing
**Price:** $Free

Zinez dev :  https://discord.gg/pkeKNN8GRX

## 🌐 Purchase Link
[Buy Now](https://zinez-dev.tebex.io/)

## 📞 Support
For any inquiries or support, please contact us through our support channel.

---

## 📜 Installation Instructions
1. Download the script files.
2. Place the script folder in your `resources` directory.
3. Add `start [folder_name]` to your server configuration file (`server.cfg`).
4. Ensure all dependencies are installed.

## 🔧 Configuration
Edit the `Config.lua` file to set up your preferences, including:
- Language settings
- Tax rates
- Discord webhook for logging events

- **Zinez dev :** https://discord.gg/pkeKNN8GRX

### Example of Config.lua:
```lua
Config = {}
Config.Language = "en" -- en or ar
Config.inventory = "qb-inventory"
Config.TaxSystem = 0.25
Config.Discord = {
    ['webhook'] = 'YOUR_DISCORD_WEBHOOK_URL',
    ['name'] = 'Pawn Shop',
    ['image'] = 'YOUR_IMAGE_URL'
}