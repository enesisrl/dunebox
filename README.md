# dunebox-packages

Store dei **pacchetti** di [Dunebox](https://github.com/kabirferro/dunebox): i binari di terze parti **customizzati** (es. PHP con estensioni) che l'installer scarica. Qui **non** c'è codice — il codice (CLI Rust, template) sta nel repo `dunebox`.

## Come funziona

I binari sono troppo grandi per git: si distribuiscono come **asset di GitHub Releases** (limite 2 GB/asset). Questo repo tiene in git solo il **tooling** di pubblicazione e la doc; `bin/` e `apps/` sono **gitignorati** (copia di lavoro locale dei pacchetti, sorgente degli zip).

Il catalogo (nomi, archive, target) è il **manifest** nel repo `dunebox` (`crates/core/embed/manifest.json`). Gli URL risultanti sono:

```
https://github.com/kabirferro/dunebox-packages/releases/download/<tag>/<archive>
```

cioè `baseUrl + archive` del manifest. **Convenzione zip**: ogni archive contiene il *contenuto* della cartella `target` (senza la cartella) → l'installer lo estrae dentro `<root>/<target>`.

## Pubblicare le Release

Prerequisito: GitHub CLI autenticata (`gh auth login`).

```powershell
# tutti i pacchetti
.\publish-releases.ps1

# opzioni
.\publish-releases.ps1 -Only php-8.2,apache    # solo alcuni
.\publish-releases.ps1 -SkipUpload             # crea solo gli zip in .dist\
.\publish-releases.ps1 -Tag packages-v2        # release diversa
```

Lo script legge il manifest, zippa ogni `target`, crea la Release (default tag `packages-v1`) se non esiste e carica gli asset con `--clobber`. Se cambi tag/owner, allinea il `baseUrl` nel manifest di `dunebox`.

## Contenuto

```
bin/    apache, php (5.4/7.4/8.2/8.5), mysql, redis, nodejs, python, git,
        composer, mailpit, cronical          (gitignored)
apps/   phpmyadmin, phpRedisAdmin            (gitignored)
publish-releases.ps1 · CLAUDE.md · .gitignore   (in git)
```

I pacchetti sono **customizzati**: non rigenerarli dalle fonti ufficiali senza riapplicare le modifiche.
