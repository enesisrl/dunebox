<p align="center">
  <img src="dunebox-icon.svg" alt="" width="110" height="110">
</p>
<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="dunebox-wordmark.svg">
    <img src="dunebox-wordmark-dark.svg" alt="Dunebox" height="42">
  </picture>
</p>

<p align="center"><strong>The complete PHP development environment for Windows. In a single folder.</strong></p>

Download a zip, extract it wherever you want, open `dunebox.exe`. On first launch a short wizard lets you choose what to install, then Dunebox downloads and configures everything by itself: web server, PHP (up to five versions at once), databases, mail, tools. No installer, no system service, nothing left in the Windows registry. When you remove it, just delete the folder.

**Freeware** — free to use, built for **Laravel and PHP** developers on Windows.

---

## ✨ What you get

- **Every PHP version at once** — 5.6 · 7.4 · 8.2 · 8.3 · 8.5, side by side, no switching
- **Many databases, even the same engine in several versions** — MySQL 9.6 + 8.0 + 5.7 + MariaDB together, each on its own port; PostgreSQL, MongoDB, Redis optional
- **A local domain + green HTTPS for every project** — `mysite.test` in seconds, trusted certificate, Apache or nginx per site
- **A smart terminal** — `php`/`artisan`/`composer` automatically use the project's PHP version
- **Built-in web tools** — phpMyAdmin (manages all MySQL/MariaDB instances), phpRedisAdmin, Mailpit
- **Cron Jobs**, **optional local DNS**, **dev tools** (Git/Node/nvm/Python/FFmpeg via their official channels), bundled **Composer**
- **Claude integration** — drive Dunebox from Claude Code / Claude Desktop
- **Truly portable** — one folder; move it, copy it, carry it on a USB stick

---

## 📥 Installation

1. Download the latest release zip (**`dunebox-vX.Y.Z.zip`**) from the [Releases](../../releases) page.
2. **Extract it** — we recommend **`C:\dunebox`** (you can use any folder, another drive, or a USB stick). That folder becomes Dunebox's home (the "root").
3. Open **`dunebox.exe`**.
4. Follow the **setup wizard**: language → general defaults (PHP/web engine, ports, autostart, terminal integration) → packages → dev tools → paths (where to keep data/config/logs) → Claude integration → DNS → logs.
5. Dunebox downloads the selected packages and configures everything. You'll get **one Windows confirmation (UAC)** to add the hosts entries and trust the local certificate.

Requirements: Windows 10/11 (64-bit), an internet connection on first launch (to download packages), ~2–3 GB of disk for a typical install.

## 🗑️ Uninstallation

Dunebox doesn't install a service or write to the registry, so removal is mostly "delete the folder":

1. **Quit Dunebox** from the tray (right-click the tray icon → *Esci/Quit*) so all services stop.
2. **Delete the Dunebox folder** (e.g. `C:\dunebox`). Your databases live in the data folder you chose — delete it too if you don't need the data.
3. Optional cleanup of the system touches Dunebox made (only if you want a spotless system):
   - **hosts file**: remove the `*.test` lines added for your sites in `C:\Windows\System32\drivers\etc\hosts`.
   - **certificate**: open *certmgr.msc* → *Trusted Root Certification Authorities* → *Certificates* and remove **Dunebox Local CA**.
   - **PATH / autostart**: if you enabled "terminal integration" or "start with Windows", remove the Dunebox `system\bin` entry from your user PATH and the `Dunebox` entry from *Startup apps*.

---

## 🚀 Usage

### Start and stop
Open `dunebox.exe`: services start automatically. The window lives in the **system tray** — closing it keeps services running; quit from the tray to stop everything. The dashboard shows the status of each service, with quick links to logs and web tools.

From a terminal you can do the same: type `dunebox` once to prepare the session, then `dunebox up` / `dunebox down`.

### Hosts (local sites)
Add a site from the **Host** tab: hostname (e.g. `mysite.test`), document root (any folder), PHP version, optional aliases, HTTPS on/off, Apache or nginx. Dunebox generates the virtual host, updates the Windows hosts file and the certificate's SAN list (one UAC prompt). New projects found in your scanned folders are proposed automatically.

CLI equivalent: `dunebox host add mysite.test --docroot C:\work\mysite\public --php 8.3 --ssl` · `dunebox host list` · `dunebox host remove mysite.test`.

### Multiple PHP versions
PHP 5.6 / 7.4 / 8.2 / 8.3 / 8.5 run together as FastCGI workers; Apache routes each request to the version chosen per host. Modern versions ship with the extensions real projects need (Imagick, GD, MongoDB driver, intl, OPcache, mbstring, cURL, PDO for MySQL/PostgreSQL/SQLite). In the terminal, `php`, `artisan` and `composer` pick the version of the project you're in — no manual switching.

### Databases — multiple engines and versions together
Run several database engines at once, and even several versions of the same engine, each on its own port and with its own data directory:

| Engine | Default port | Users (password `secret`) |
|---|---|---|
| MySQL 9.6 / 8.0 / 5.7 | `3306` / `3307` / `3308` | `dunebox`, `root` |
| MariaDB | `3309` | `dunebox`, `root` |
| PostgreSQL | `5432` | `dunebox`, `postgres` |
| MongoDB | `27017` | — |
| Redis | `6379` | — |

Enable the ones you want from **Settings → Packages** and set each engine's **port** there. Connect from your app's `.env` with host `127.0.0.1`, the right port, user `dunebox`, password `secret`. Every package's box has an **ℹ Info** button showing its exact connection details. Credentials are created automatically on first init; data lives in a folder you choose and survives updates.

### Web tools (in the browser)
Reachable over HTTP and HTTPS (green padlock, trusted cert):

| Tool | URL |
|---|---|
| phpMyAdmin — manages **all** MySQL/MariaDB instances (pick the server from the dropdown) | `http://phpmyadmin.localhost` |
| phpRedisAdmin | `http://phpredisadmin.localhost` |
| Mailpit — every email sent from PHP lands here | `http://mailpit.localhost` |

**Email**: PHP is preconfigured to deliver to Mailpit. For direct SMTP from Laravel use `MAIL_HOST=127.0.0.1`, `MAIL_PORT=1025`, no username/password (the Mailpit package's Info button has a copy-ready `.env`).

### Cron Jobs
Schedule jobs from the **Cron Jobs** tab with a guided editor (no crontab syntax needed). **Global** jobs live in the instance; **per-project** jobs live in the project (`.dunebox`) and travel with it in git, so teammates inherit them. Each job runs with the project's PHP version; they run only while Dunebox is on. CLI: `dunebox cron list`.

### Terminal integration & Composer
Enable "terminal integration" (Settings → General) and the `dunebox` command becomes available in cmd and PowerShell. Composer is bundled inside Dunebox and always runs with the correct PHP/extensions for your project.

### Dev tools
From **Settings → Development tools** install/update/remove Git, Node.js, nvm, Python (2 and 3) and FFmpeg from their official channels (winget); Composer is managed by Dunebox. Update badges appear when a new version is out.

### Local DNS (optional)
Turn on the built-in wildcard DNS (Settings/DNS) and `*.test` resolves to your machine automatically — no hosts-file entries. Off by default.

### Claude integration
From the wizard or **Settings → Claude integration**, enable the integration with **Claude Code** / **Claude Desktop**: Claude can list/create hosts, manage Cron Jobs, check service status, read logs and run `artisan`/`composer` with the right PHP, via a bundled skill and an MCP server.

### Notifications
Transient results appear as **toasts** (green = success, red = error). Anything that needs your action (pending hosts/cert sync, malformed project config, available tool updates, untrusted certificate) is collected in the **Notifications** center with a one-click link to fix it.

### Portability
Everything — software, config, Composer, databases — is in one folder. Move or copy it and Dunebox detects the change and realigns paths, PATH and autostart on next launch.

---

## ⌨️ CLI reference

Type `dunebox` to prepare the session, then:

| Command | What it does |
|---|---|
| `dunebox up` / `down` | start / stop all services |
| `dunebox host add\|list\|remove …` | manage hosts (vhost + hosts file + certificate) |
| `dunebox package list\|enable\|disable\|install …` | manage components |
| `dunebox cron list` | list scheduled Cron Jobs |
| `dunebox env` | environment status (root, default PHP, tools) |
| `php` · `artisan` · `composer` | use the current project's PHP version automatically |

## ✅ Compatibility

| | |
|---|---|
| **OS** | Windows 10 / 11 (64-bit) |
| **PHP** | 5.6 · 7.4 · 8.2 · 8.3 · 8.5 (all active at once) |
| **Databases** | MySQL 9.6/8.0/5.7 · MariaDB · PostgreSQL · MongoDB · Redis (multiple at once) |
| **Frameworks** | Laravel (all versions, legacy included) and any PHP project |
| **Permissions** | one UAC confirmation for hosts + certificate; no service installed |

---

## ⭐ Like it?

If Dunebox is useful to you, leave a **★ Star** and click **👁 Watch** at the top of this page to follow new releases. It helps a lot.

## License

Dunebox is **freeware**: free to use under its [End User License Agreement](LICENSE). The third-party components it installs keep their own (open source / freeware) licenses.
