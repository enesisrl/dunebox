<p align="center">
  <img src="dunebox-icon.svg" alt="" width="110" height="110">
</p>
<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="dunebox-wordmark.svg">
    <img src="dunebox-wordmark-dark.svg" alt="Dunebox" height="42">
  </picture>
</p>

<p align="center"><strong>The complete PHP development environment for Windows.</strong></p>

Download a zip, extract it wherever you want, open `dunebox.exe`. On first launch a short wizard lets you choose what to install, then Dunebox downloads and configures everything by itself: web server, several PHP versions side by side, databases, mail, tools. No installer, no Windows service — when you remove it, just delete the folder.

<p align="center">
  <picture>
    <img src="dunebox-screenshot.png" alt="Dunebox">
  </picture>
</p>

<p align="center"><strong>Freeware</strong> — free to use, built for <strong>Laravel and PHP</strong> developers on Windows.</p>

<p align="center">
  <a href="../../releases/latest"><strong>⬇ Download</strong></a> ·
  <a href="https://dunebox.enesi.it/docs.html" target="_blank"><strong>📖 Documentation</strong></a> ·
  <a href="https://dunebox.enesi.it" target="_blank"><strong>🌐 Website</strong></a>
</p>

---

## ✨ What you get

- **Every PHP version at once** — legacy to latest, side by side, no switching
- **Many databases, even several versions of the same engine** — MySQL, MariaDB, PostgreSQL, MongoDB and Redis, each on its own port
- **A local domain + green HTTPS for every project** — `mysite.test` in seconds, trusted certificate, Apache or nginx per site
- **PHP settings per version** — memory limit, upload size, execution time, errors, without editing `php.ini`
- **Xdebug with one switch** — step debugging and test coverage for every modern PHP version
- **Logs and dumps in one place** — every log (services, PHP, web server, Laravel) and Laravel/Symfony `dump()`/`dd()` captured in the app, live
- **A smart terminal** — `php`/`artisan`/`composer`/`mysql` automatically use the current project's PHP version and database
- **Built-in web tools** — phpMyAdmin, phpRedisAdmin, Mailpit
- **Diagnostics with one-click fixes** — busy ports, untrusted certificate, hosts file, PATH: found and fixed from the app
- **Cron Jobs**, **optional local DNS**, **dev tools** (Git, Node.js, Python) and bundled **Composer**
- **Claude integration** — drive Dunebox from Claude Code / Claude Desktop
- **Private by default** — every service listens on your PC only, and commands from a project's config need your explicit approval
- **Updates itself** — new versions install from the app, your configuration and data stay untouched
- **Truly portable** — one folder; move it, copy it, carry it on a USB stick

A free alternative to Laragon, XAMPP and Laravel Herd on Windows — see the [comparison](https://dunebox.enesi.it/compare.html).

---

## 📥 Get started

1. Download **`dunebox-vX.Y.Z.zip`** from the [latest release](../../releases/latest).
2. **Extract it** wherever you like — we recommend **`C:\dunebox`** (another drive or a USB stick works too).
3. Open **`dunebox.exe`** and follow the short setup wizard. Dunebox downloads what you chose and configures everything, with **one Windows confirmation (UAC)** to add the local domains and trust the certificate.

Requirements: Windows 10/11 (64-bit), an internet connection on first launch, ~2–3 GB of disk for a typical install.

## ✅ Compatibility

| | |
|---|---|
| **OS** | Windows 10 / 11 (64-bit) |
| **PHP** | Multiple versions at once, from legacy to the latest |
| **Databases** | MySQL, MariaDB, PostgreSQL, MongoDB, Redis — several at once |
| **Web servers** | Apache and nginx, chosen per site |
| **Frameworks** | Laravel (any version, legacy included), WordPress, Symfony and any PHP project |
| **Permissions** | one UAC confirmation for local domains + certificate; no Windows service installed |

## 📖 Documentation

The full guide lives at **[dunebox.enesi.it/docs.html](https://dunebox.enesi.it/docs.html)** — installation, hosts, PHP versions and settings, Xdebug, databases & credentials, email, HTTPS, Cron Jobs, logs, the CLI, Claude integration and uninstall, with the exact versions shipped in each release.

---

## ⭐ Like it?

If Dunebox is useful to you, leave a **★ Star** and click **👁 Watch** at the top of this page to follow new releases. It helps a lot.

## License

Dunebox is **freeware**: free to use under its [End User License Agreement](LICENSE). The third-party components it installs keep their own (open source / freeware) licenses.