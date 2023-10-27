<div align="center">
<h1>dotfiles</h1>
<p><b>Dotfiles Setup Script for the WEBKINDER macOS Development Environment.</b></p>
</div>

## Requirements
- Fresh macOS installation

## Installation
- Open the terminal application and run the following command to install Homebrew:
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- Download this repository and place it in your `~` folder and rename it to `.dotfiles`.
- `cd ~/.dotfiles` into the folder and run `./bootstrap`

## Post-Installation Steps
- Create a GitHub Access Token (classic) on [this](https://github.com/settings/tokens) page.
- Name it `WEBKINDER_YARN_PACKAGES`.
- Set expiration to `No expiration`.
- Check the scope `write:packages`.
- Copy the generated access token starting with `ghp_`
- Past the access token into your `~/.dotfiles/5-dev-env/.npmrc` file. The final result should look like this:
```
@webkinder:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=ghp_************
```
