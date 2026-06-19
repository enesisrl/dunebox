# Dunebox

**The complete PHP development environment for Windows. In a single folder.**

Download a zip, extract it wherever you want, open `dunebox.exe`. On first launch Dunebox downloads and configures everything by itself: web server, PHP (in five versions at once), database, mail, tools. No installer, no system service, nothing in the Windows registry. When you close Dunebox, your PC is exactly as it was.

Open source (MIT), built for **Laravel and PHP** developers on Windows.

---

## ✨ What it does

### 🐘 Every PHP version, together
PHP **5.6, 7.4, 8.2, 8.3 and 8.5** run side by side, always. The legacy project stays on 5.6, the new one runs on 8.5 — at the same time, no switching, no restarts. Each site picks its version with one click. Every modern version ships with the extensions real projects need already on — **Imagick** and **GD** for images, the **MongoDB** driver, **intl**, **OPcache**, **mbstring**, **cURL**, and **PDO** for MySQL, PostgreSQL and SQLite.

### 🌐 A local domain for every project
`mysite.test` in seconds: choose a name, a folder and a PHP version — Dunebox generates the virtual host, updates the Windows hosts file and the certificate. Aliases and multiple domains included. Prefer Apache or nginx? Pick the engine per site.

### 🔒 Green HTTPS, even locally
A local certificate authority, generated and **trusted automatically** — once. Every `.test` site runs over HTTPS with the green padlock and no browser warnings, in **Chrome, Edge and Firefox**. New sites are trusted instantly, no extra steps.

### ⌨️ A smart terminal
Type `dunebox` once and your terminal is ready (correct PATH and tools, in both cmd and PowerShell). From then on `php`, `artisan` and `composer` **automatically use the right PHP version for the project you're in** — no manual switching. Run `composer install` in a legacy project and it uses that project's PHP; in a modern one, the modern PHP. The matching `php.ini` (with the right extensions) is loaded for you.

### 🎼 Composer, included and portable
Composer comes **with Dunebox**, inside the folder — nothing scattered across your PC. It always runs with the correct PHP and extensions for your project (openssl, mbstring, …), and travels with the environment when you move it.

### 📬 Emails don't leave: you see them
Every email sent from PHP lands in a **local inbox** ([Mailpit](http://mailpit.localhost)) with HTML preview, source and live updates. Zero configuration, zero test emails accidentally sent to real clients.

### 🗄️ Databases ready to go
**MySQL** with [phpMyAdmin](http://phpmyadmin.localhost) and **Redis** with [phpRedisAdmin](http://phpredisadmin.localhost), already wired up and reachable from the browser. Need something else? **PostgreSQL** and **MongoDB** are one toggle away. Your data stays yours, in a folder you choose — it survives updates and reinstalls.

Ready-to-use credentials, created automatically on first launch:

| Database | Host | Port | User | Password |
|---|---|---|---|---|
| MySQL | `127.0.0.1` | `3306` | `dunebox` (or `root`) | `secret` |
| PostgreSQL | `127.0.0.1` | `5432` | `dunebox` (or `postgres`) | `secret` |

Point your app's `.env` at `127.0.0.1` with user `dunebox` and password `secret` and you're connected.

### ⏰ Cron Jobs, built in
Schedule jobs with a **guided editor** (no crontab syntax to memorise) — `php artisan schedule:run`, backups, anything — and Dunebox runs them with the project's correct PHP version. Per-project jobs live in the project's `.dunebox/config.json` and travel with it in git: your teammates inherit them. System-wide jobs go in the global scheduler. Everything runs only while Dunebox is on.

```json
"cron": [
  "* * * * *  php artisan schedule:run",
  "0 3 * * *  php artisan backup:run"
]
```

### 🌍 Optional local DNS
Turn on the built-in wildcard DNS and `*.test` resolves to your machine automatically — **no entries in the Windows hosts file**. Off by default; classic hosts-file mode otherwise.

### 🧰 The toolbox, one click away
Dunebox installs, updates and removes the dev tools you want — **Git, Node.js, nvm, Python (2 and 3, side by side) and FFmpeg** (from their official sources) — and notifies you when a new version is out. Together with the bundled Composer, they're available as commands in any terminal (`python` and `python3` included).

### 🔔 Everything in one place
A graphical dashboard: service status at a glance, host and Cron Jobs management, quick access to tools, logs one click away. All alerts and prompts are collected in a single **Notifications** center. It lives in the system tray: close the window and the services keep running.

### 📦 Install only what you need
Don't use Redis? Turn it off. Every component toggles on and off individually, and dependencies resolve themselves. Want a PHP version that isn't on the list? Add it with one line of configuration — no need to wait for an update.

### ✋ Your changes are respected
Hand-tweaked `php.ini` or `httpd.conf`? Dunebox **won't overwrite them**: updates and installs only touch what's missing. A full regeneration happens only when you ask for it.

### 🎒 Truly portable
Everything — software, configuration, Composer, projects, databases — lives in one folder. Copy it to another drive, carry it on a USB stick, move it to another PC: Dunebox detects the move and realigns itself. Perfect for keeping a whole team on the same stack.

---

## 🚀 Get going in three steps

1. **Download** the zip from the latest release and **extract** it wherever you like (that folder becomes your home)
2. **Open `dunebox.exe`** — a short setup wizard lets you pick packages, PHP versions and folders, then downloads and configures everything
3. **Create your first host**: name, folder, PHP version → `https://mysite.test` is online

## ⌨️ From the terminal too

Everything the dashboard does, you can do from the command line — handy for automation and for those who live in the terminal. Type `dunebox` to prepare the session, then:

| Command | What it does |
|---|---|
| `dunebox up` / `down` | start / stop all services |
| `dunebox host add mysite.test ...` | create a new host (vhost + hosts + certificate) |
| `dunebox host list` | list configured hosts |
| `dunebox package list` | show components and their status |
| `dunebox package enable / disable <name>` | turn a component on/off |
| `dunebox cron list` | show scheduled Cron Jobs |
| `dunebox env` | environment status (root, default PHP, tools) |

And `php`, `artisan` and `composer` **automatically use the PHP version of the project you're in**.

## ✅ Compatibility & requirements

| | |
|---|---|
| **Operating system** | Windows 10 and Windows 11 (64-bit) |
| **PHP** | 5.6 · 7.4 · 8.2 · 8.3 · 8.5 — all active at once |
| **Frameworks** | Laravel (all versions, legacy included) and any PHP project |
| **Disk space** | ~2–3 GB for a full install (only the active components) |
| **Connection** | needed only on first launch, to download the packages |
| **Permissions** | a single Windows confirmation for hosts and certificate; no service installed |
| **Browser** | Edge and Chrome resolve `.localhost` on their own; Dunebox handles the `.test` domains |

Nothing to uninstall: to remove Dunebox, just delete the folder.

## 🔗 Tools in your browser

Reachable over both HTTP and HTTPS (green padlock, same trusted certificate):

| Tool | URL |
|---|---|
| phpMyAdmin | `http://phpmyadmin.localhost` · `https://…` |
| phpRedisAdmin | `http://phpredisadmin.localhost` · `https://…` |
| Mailpit | `http://mailpit.localhost` · `https://…` |

## 📦 What's inside

Apache (or nginx) · PHP 5.6 / 7.4 / 8.2 / 8.3 / 8.5 · MySQL — with PostgreSQL and MongoDB optional · Redis · Mailpit · phpMyAdmin · phpRedisAdmin · a bundled Composer — all open source or freeware. Git, Node.js, nvm, Python (2 and 3) and FFmpeg can be added (and removed) with one click from the wizard or the Settings.

---

## License

Dunebox is **open source** under the [MIT](LICENSE) license.
