# 🧪 Nix Flake Development Environments

This repository provides **Nix flake** configurations for setting up **isolated** and **reproducible** development environments across a range of technologies.

Currently supported environments:
- 🟢 **Node.js** — [`node/flake.nix`](node/flake.nix)
- 🐍 **Python** — [`python/flake.nix`](python/flake.nix)
- 🌍 **Terraform** — [`terraform/flake.nix`](terraform/flake.nix)

---

## ✅ Prerequisites

- **Nix Package Manager**  
  You must have [Nix](https://nixos.org/) installed.
- **Flakes Enabled**  
  Make sure you have flakes enabled in your Nix configuration:
  Add this to your `~/.config/nix/nix.conf` (or `/etc/nix/nix.conf`):
  ```conf
  experimental-features = nix-command flakes
  ```

## 🚀 Usage

Each environment has its own flake.nix file in a dedicated directory.
Replace ${ENV} with one of the available environments (node, python, terraform).

### Initialise in the current directory
```bash
nix flake init -t "github:fel-haj/nix-dev#${ENV}"
```

### Create a new project in a separate directory
```bash
nix flake new -t "github:fel-haj/nix-dev#${ENV}" ${NEW_PROJECT_DIRECTORY}
```

## 🧑‍💻 Using the Development Shell

Once initialised, you can activate the environment using one of the following methods:

### With direnv
```bash
direnv allow
```

### Without direnv
```bash
nix develop
```

## 🛠 Optional: Automate with a mkdev Script

You can simplify the setup using a helper script with direnv:

```bash
echo 'use flake "github:fel-haj/nix-dev?dir=$1"' >> .envrc
direnv allow
```

Save the script (e.g. mkdev) in a directory like ~/.bin, and ensure it's in your PATH:

```bash
# ~/.envrc:
PATH_add "$HOME/.bin"
```

To allow direnv to search up through parent directories, add the following:
```bash
source_up .envrc
```

Refer to the direnv manual for more info.

You can then run:
```bash
mkdev node
```
...inside any project directory.f you name your script mkdev for instance, then you could execute 'mkdev node' in the project's directory where you intend to use the tech-stack.
