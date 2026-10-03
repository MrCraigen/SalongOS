# SalongOS

**A Bazzite-based HTPC image with Plasma Bigscreen for the living room.**

SalongOS is a custom [bootc](https://github.com/bootc-dev/bootc) image built on top of [Bazzite](https://bazzite.gg) (`bazzite-deck`). It adds [Plasma Bigscreen](https://plasma-bigscreen.org/) from KDE, so your home theater PC boots into a TV-friendly interface, while Steam Gaming Mode is still one click away.

> SalongOS is an unofficial, personal project. It is not affiliated with or endorsed by Bazzite, Universal Blue, KDE or Valve.

---

## Features

- **Boots straight into Plasma Bigscreen** instead of Steam Big Picture.
- **"Switch to Desktop" in Steam goes to Bigscreen**, not the regular Plasma desktop.
- **Back to Steam Gaming Mode** from Bigscreen with a built-in launcher (*Steam Gaming Mode*).
- Everything from Bazzite: gaming-ready drivers, Steam, Flatpak, atomic updates and rollback.
- Built and signed automatically with GitHub Actions, and updated by pulling the latest Bazzite.

## Requirements

- A PC that already runs **Bazzite** (the `bazzite-deck` variant is recommended).
- AMD or Intel graphics. NVIDIA is untested.
- A TV or monitor, and a controller, remote or keyboard/mouse.

## Install

On a machine running Bazzite:

```bash
sudo bootc switch ghcr.io/mrcraigen/salongos
systemctl reboot
```

After the reboot, make Bigscreen the default session:

```bash
steamosctl set-default-desktop-session plasma-bigscreen-wayland.desktop
steamosctl set-default-login-mode desktop
systemctl reboot
```

These are saved as user settings, so they are only needed once per installation and survive image updates.

## Usage

| I want to... | Do this |
|---|---|
| Go to Steam Gaming Mode | Open **Steam Gaming Mode** in Bigscreen, or run `steamosctl switch-to-game-mode` |
| Go back to Bigscreen | In Steam: **Power → Switch to Desktop**, or just reboot |
| Check the defaults | `steamosctl get-default-login-mode` and `steamosctl get-default-desktop-session` |
| Update | `sudo bootc upgrade && systemctl reboot` |
| Roll back | `sudo bootc rollback && systemctl reboot` |

### Stuck on a black screen?

Switch to a TTY with `Ctrl+Alt+F3` (or log in over SSH) and restore Gaming Mode as the default:

```bash
steamosctl set-default-login-mode game
systemctl reboot
```

## Build your own

This repo was created from [`ublue-os/image-template`](https://github.com/ublue-os/image-template).

1. Use this repo as a template, or fork it.
2. Create a key pair with `cosign generate-key-pair` and add the private key as the repository secret `SIGNING_SECRET`. Commit only `cosign.pub`.
3. Edit `image-template.env` with your image name and username.
4. Change packages in `build_files/build.sh` and add files under `system_files/`.
5. Push to `main`. GitHub Actions builds the image. Set the package visibility to **Public** so it can be pulled without logging in.

## Known limitations

- Plasma Bigscreen is still a young project. Expect rough edges and apps that are not designed for remote control.
- Session switching in Bazzite has had bugs in the past. If something misbehaves, see the black-screen recovery above.

## Credits

- [Bazzite](https://github.com/ublue-os/bazzite) and [Universal Blue](https://universal-blue.org/)
- [Plasma Bigscreen](https://plasma-bigscreen.org/) by KDE
- [blueHTPC](https://github.com/douglascdev/blueHTPC) for inspiration

## License

Apache 2.0, see [LICENSE](LICENSE).
