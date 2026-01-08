# Homebrew Tap for NoBrainDev

Official Homebrew tap for [NoBrainDev](https://github.com/techbruwh/nobraindev) - AI-powered code snippet manager.

## Installation

```bash
brew tap techbruwh/nobraindev
brew install nobraindev
```

## Update

```bash
brew upgrade nobraindev
```

## Uninstall

```bash
brew uninstall nobraindev
brew untap techbruwh/nobraindev
```

## For Maintainers

### 🤖 Automatic Updates Setup

To enable automatic cask updates when releasing new versions:

#### One-Time Setup:

1. **Create a Personal Access Token (PAT):**
   - Go to GitHub Settings → Developer settings → [Personal access tokens](https://github.com/settings/tokens) → Tokens (classic)
   - Click "Generate new token (classic)"
   - Give it a name: `Homebrew Tap Auto-Update`
   - Select scope: ✅ `repo` (Full control of private repositories)
   - Click "Generate token"
   - **Copy the token** (you won't see it again!)

2. **Add token to main repository:**
   - Go to [`techbruwh/nobraindev`](https://github.com/techbruwh/nobraindev) repository
   - Settings → Secrets and variables → Actions
   - Click "New repository secret"
   - Name: `HOMEBREW_TAP_TOKEN`
   - Secret: Paste your PAT
   - Click "Add secret"

3. **Update release workflow in main repo:**
   - Edit `.github/workflows/release.yml` (or your release workflow file)
   - Add this job after your build job:

```yaml
notify-homebrew:
  runs-on: ubuntu-latest
  needs: [build]  # Replace with your actual build job name
  steps:
    - name: Trigger Homebrew tap update
      run: |
        VERSION="${{ github.event.release.tag_name }}"
        VERSION="${VERSION#v}"  # Remove 'v' prefix if present
        
        curl -X POST \
          -H "Accept: application/vnd.github.v3+json" \
          -H "Authorization: token ${{ secrets.HOMEBREW_TAP_TOKEN }}" \
          https://api.github.com/repos/techbruwh/homebrew-nobraindev/dispatches \
          -d "{\"event_type\":\"new-release\",\"client_payload\":{\"version\":\"${VERSION}\"}}"
```

4. **Enable workflow permissions (this repo):**
   - Go to this repo's Settings → Actions → General
   - Under "Workflow permissions", select: ✅ **Read and write permissions**
   - Click "Save"

#### ✅ Done! Now when you:
1. Create a release in `techbruwh/nobraindev` with DMG files
2. The Homebrew cask updates automatically within minutes
3. Check progress in the [Actions tab](../../actions)

### Manual Update Options

If you need to update manually:

**Option 1: GitHub Actions UI**
- Go to [Actions](../../actions) → "Update Homebrew Cask" → "Run workflow"
- Enter version number → Run

**Option 2: Local Script**
```bash
./update-cask.sh 0.2.6
```

See [MAINTENANCE.md](MAINTENANCE.md) for detailed instructions.

---

## Issues

- **App issues**: [Main repository](https://github.com/techbruwh/nobraindev/issues)
- **Installation issues**: [Open an issue here](https://github.com/techbruwh/homebrew-nobraindev/issues)

## About

NoBrainDev is a fast, AI-powered code snippet manager built with Rust and React. Features include:

- 📝 Organize snippets by language and tags
- 🔍 Smart keyword search
- 🤖 AI semantic search (natural language)
- 💾 Local-first with SQLite
- ⚡ Fast and lightweight

---

Made with ❤️ by [TechBruwh](https://github.com/techbruwh)

