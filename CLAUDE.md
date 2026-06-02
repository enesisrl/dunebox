# CLAUDE.md — dunebox-packages

Repo **store dei pacchetti** di [Dunebox](https://github.com/kabirferro/dunebox). Qui vivono i binari di terze parti **customizzati** (es. PHP con estensioni) che l'installer di Dunebox scarica. Non è il codice: il codice (CLI Rust, template) sta nel repo `dunebox`.

## Cosa contiene

```
bin/        apache, php (5.4/7.4/8.2/8.5), mysql, redis, nodejs, python, git,
            composer, mailpit, cronical  — pacchetti estratti
apps/       phpmyadmin, phpRedisAdmin
publish-releases.ps1   script di pubblicazione (zip + GitHub Release)
```

I path `bin/...` e `apps/...` sono **root-relative**: combaciano 1:1 con i `target` del manifest in `dunebox` (`crates/core/embed/manifest.json`).

## Regola git — i binari NON si committano

Sono enormi e non vanno nella storia git: `bin/` e `apps/` sono **gitignorati**. In git stanno solo lo script di pubblicazione e questa doc. I binari **veri** si distribuiscono come **asset di GitHub Releases** (limite 2 GB/asset). Questo repo serve come *home* delle Release e come copia di lavoro locale dei pacchetti.

## Pubblicare le Release

Il **manifest** nel repo `dunebox` è la sorgente di verità del catalogo (nome, archive, target). Lo script legge il manifest, zippa ogni pacchetto e carica gli asset su un'unica Release (tag `packages-v1`).

**Convenzione zip**: l'archive contiene il **contenuto** della cartella `target` (senza la cartella stessa). L'installer estrae dentro `<root>/<target>`. Lo script usa `ZipFile.CreateFromDirectory(..., includeBaseDirectory:$false)` → esattamente questa forma.

### Procedura

1. **Una volta**: autenticati con GitHub CLI (interattivo):
   ```powershell
   gh auth login
   ```
2. Pubblica tutto:
   ```powershell
   .\publish-releases.ps1
   ```
   Opzioni utili:
   - `-Only php-8.2,apache` → pubblica solo alcuni componenti;
   - `-SkipUpload` → crea solo gli zip in `.dist\` senza caricarli (per provare);
   - `-Tag <tag>` → release diversa (default `packages-v1`);
   - `-Manifest <path>` → manifest diverso (default `..\dunebox\crates\core\embed\manifest.json`).

Gli URL risultanti sono `https://github.com/kabirferro/dunebox-packages/releases/download/<tag>/<archive>` — cioè `baseUrl + archive` del manifest. Se cambi tag o owner, allinea il `baseUrl` nel manifest.

## Note

- I pacchetti sono **customizzati**: non rigenerarli dalle fonti ufficiali senza riapplicare le modifiche (es. estensioni PHP).
- `php-X` → il manifest deriva da qui il `php.<v>.dir` di `dunebox.json` (niente duplicazione manuale).
- Zippare `python`/`nodejs`/`git` è lento (cartelle grandi): è normale.
