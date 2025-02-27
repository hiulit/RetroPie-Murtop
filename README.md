# RetroPie Murtop

![GitHub release (latest by date)](https://img.shields.io/github/v/release/hiulit/RetroPie-Murtop?style=flat-square) ![GitHub license](https://img.shields.io/github/license/hiulit/RetroPie-Murtop?style=flat-square)

A script to install Murtop on Retropie.

ℹ️ **Murtop will be installed in the `ports` section.**

![RetroPie Murtop banner](banner.jpg)

## ⚠️ Prerequisites

You have to own a copy of Murtop, which you can buy on [itch.io](https://hiulit.itch.io/murtop).

[![Purchase Murtop on itch.io](images/itchio_widget.jpg)](https://hiulit.itch.io/murtop/purchase)

When you download Murtop from [itch.io](https://hiulit.itch.io/murtop), you get a zip file (`murtop_[ARCH].zip`). You'll have to place it in `~/RetroPie-Murtop/bin` after completing the [script installation](#install-the-script).

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

The script assumes that you are running it on a Raspberry Pi with the `RetroPie-Setup` folder located at `~/RetroPie-Setup`. If your setup differs, you can pass the path where your `RetroPie-Setup` folder is located as a parameter, like this:

```sh
sudo ./retropie_murtop.sh [install|uninstall] "/path/to/your/RetroPie-Setup"
```

## 📖 Options

- `--help`: Prints the help message.
- `--install [path]`: Installs Murtop on RetroPie.
  - Path: The location of the `RetroPie-Setup` folder.
  - Default: `~/RetroPie-Setup`.
- `--uninstall [path]`: Uninstalls Murtop from RetroPie.
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

## 📝 License

[MIT License](/LICENSE).
