# RetroPie Murtop

A script to install Murtop on Retropie.

ℹ️ **Murtop will be installed in the `ports` section.**

### ⚠️ Prerequisites

You have to own a copy of Murtop, which you can buy it at https://hiulit.itch.io/murtop.

When you download Murtop from itch.io, you get a zip file (`murtop_[ARCH].zip`). You'll have to place it at `~/RetroPie-Murtop/bin` after the [script installation](#install-the-script).

## 🛠️ Setup script

### Install the script

```sh
cd ~
git clone https://github.com/hiulit/RetroPie-Murtop.git
cd ~/RetroPie-Murtop/
sudo chmod +x retropie_murtop.sh
```

### Update the script

```sh
cd ~/RetroPie-Murtop/
git pull
```

## 🚀 Usage

```sh
sudo ./retropie_murtop.sh [OPTIONS]
```

If no options are passed, you will be prompted with a usage example:

```sh
USAGE: sudo ./retropie_murtop.sh [OPTIONS]

Use 'sudo ./retropie_murtop.sh --help' to see all the options.
```

The script assumes that you are running it on a Raspberry Pi with the `RetroPie-Setup` folder being stored in `~/RetroPie-Setup`. If your setup differs, you can pass the path where your `RetroPie-Setup` folder is stored as a parameter, like this:

```sh
sudo ./retropie_murtop.sh [install|uninstall] "/path/to/your/RetroPie-Setup"
```

## 📖 Options

- `--help`: Prints the help message.
- `--install [path]`: Installs Murtop on RetroPie.
  - Path: The location of the `RetroPie-Setup` folder.
  - Default: `~/RetroPie-Setup`.
- `--uninstall [path]`: Uninstalls Murtop on RetroPie.
  - Path: The location of the `RetroPie-Setup` folder.
  - Default: `~/RetroPie-Setup`.
- `--version`: Prints the script version.

## 🗒️ Changelog

See [CHANGELOG](/CHANGELOG.md).

## 👤 Author

**hiulit**

- Twitter: [@hiulit](https://twitter.com/hiulit)
- GitHub: [@hiulit](https://github.com/hiulit)

## 🤝 Contributing

Feel free to:

- [Open an issue](https://github.com/hiulit/RetroPie-Murtop/issues) if you find a bug.
- [Create a pull request](https://github.com/hiulit/RetroPie-Murtop/pulls) if you have a new cool feature to add to the project.
- [Start a new discussion](https://github.com/hiulit/RetroPie-Murtop/discussions) about a feature request.

## 🙌 Supporting this project

If you love this project or find it helpful, please consider supporting it through any size donations to help make it better ❤️.

[![Become a patron](https://img.shields.io/badge/Become_a_patron-ff424d?logo=Patreon&style=for-the-badge&logoColor=white)](https://www.patreon.com/hiulit)

[![Suppor me on Ko-Fi](https://img.shields.io/badge/Support_me_on_Ko--fi-F16061?logo=Ko-fi&style=for-the-badge&logoColor=white)](https://ko-fi.com/F2F7136ND)

[![Buy me a coffee](https://img.shields.io/badge/Buy_me_a_coffee-FFDD00?logo=buy-me-a-coffee&style=for-the-badge&logoColor=black)](https://www.buymeacoffee.com/hiulit)

[![Donate Paypal](https://img.shields.io/badge/PayPal-00457C?logo=PayPal&style=for-the-badge&label=Donate)](https://www.paypal.com/paypalme/hiulit)

If you can't, consider sharing it with the world...

[![](https://img.shields.io/badge/Share_on_Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/intent/tweet?url=https%3A%2F%2Fgithub.com%2Fhiulit%2FRetroPie-Murtop&text="RetroPie+Murtop"%0AA+script+to+install+%23Murtop+on+%23RetroPie.%0Aby+%40hiulit%0A)

... or giving it a [star ⭐️](https://github.com/hiulit/RetroPie-Godot-Engine-Emulator/stargazers).

Thank you very much!


## 📝 License

[MIT License](/LICENSE).
