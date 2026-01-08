# Tap Maintenance Guide

Quick guide for updating the Homebrew tap when releasing new versions.

## 🤖 Automated Update (Recommended)

### Option 1: GitHub Actions (Fully Automated)

The cask updates **automatically** when you create a new release in the main repository!

**Setup (One-time):**

1. **Create Personal Access Token:**
   - Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
   - Generate new token with `repo` scope
   - Copy the token

2. **Add token to main nobraindev repository:**
   - Go to `techbruwh/nobraindev` repository
   - Settings → Secrets and variables → Actions
   - New repository secret: `HOMEBREW_TAP_TOKEN` = your PAT

3. **Add this to your main repo's release workflow** (`.github/workflows/release.yml`):

```yaml
notify-homebrew:
  runs-on: ubuntu-latest
  needs: [build]  # Wait for your build job to complete
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

4. **Enable workflow permissions** (in this homebrew-nobraindev repo):
   - Settings → Actions → General → Workflow permissions
   - Select "Read and write permissions"
   - Save

**Usage:**
- Create a release in the main repo → Cask updates automatically! 🎉
- Check progress: Actions tab → "Update Homebrew Cask"

### Option 2: Manual Trigger via GitHub Actions

If you need to manually trigger an update:

1. Go to this repository's **Actions** tab
2. Click **"Update Homebrew Cask"** workflow
3. Click **"Run workflow"**
4. Enter the version number (e.g., `0.2.6`)
5. Click **"Run workflow"**

The workflow will automatically:
- Download both DMG files
- Calculate SHA256 checksums
- Update `Casks/nobraindev.rb`
- Commit and push changes

### Option 3: Local Script

For local testing or manual updates:

```bash
./update-cask.sh 0.2.6
```

This script will:
- Download both architecture DMG files
- Calculate SHA256 checksums
- Output the complete cask file content
- You can then copy/paste to `Casks/nobraindev.rb`

---

## 📝 Manual Update (Legacy)

### 1. Download Release Files

After creating a new release on GitHub:

```bash
cd ~/Downloads

# Download both architectures
wget https://github.com/techbruwh/nobraindev/releases/download/v0.1.0/NoBrainDev_0.1.0_aarch64.dmg
wget https://github.com/techbruwh/nobraindev/releases/download/v0.1.0/NoBrainDev_0.1.0_x64.dmg
```

### 2. Calculate SHA256 Checksums

```bash
shasum -a 256 NoBrainDev_0.1.0_aarch64.dmg
shasum -a 256 NoBrainDev_0.1.0_x64.dmg
```

Copy the output hashes.

### 3. Update Cask Formula

Edit `Casks/nobraindev.rb`:

```ruby
version "0.2.0"  # ← Update this

sha256 arm:   "abc123...",  # ← Paste aarch64 SHA256 here
       intel: "def456..."   # ← Paste x64 SHA256 here
```

### 4. Test the Formula

```bash
brew tap techbruwh/nobraindev /Users/faisalmorensya/app/techbruwh/homebrew-nobraindev

# Check syntax
brew audit --cask --strict techbruwh/nobraindev/nobraindev

# Fix style issues
brew style --fix Casks/nobraindev.rb

# Test install
brew reinstall nobraindev

# Test the app
open -a NoBrainDev
```

### 5. Commit and Push

```bash
git add Casks/nobraindev.rb
git commit -m "Update NoBrainDev to v0.2.0"
git push origin main
```

### 6. Notify Users

Users can now upgrade:
```bash
brew upgrade nobraindev
```

## Testing Checklist

Before pushing:

- [ ] Version number updated
- [ ] Both SHA256 checksums updated
- [ ] `brew audit` passes
- [ ] Local install works
- [ ] App launches successfully
- [ ] Committed and pushed

## Common Issues

### SHA256 Mismatch Error

**Error**: `SHA256 mismatch`

**Solution**:
1. Re-download the .dmg files
2. Recalculate SHA256
3. Update the cask
4. Clear Homebrew cache: `brew cleanup`

### App Won't Launch

**Check**:
- Is the .dmg properly built?
- Is the GitHub release public?
- Can you download manually?
- Does the app have all required architectures?

### Formula Syntax Errors

**Fix**:
```bash
brew style --fix Casks/nobraindev.rb
```

## Quick Reference

```bash
# Test locally
brew reinstall nobraindev

# Uninstall
brew uninstall nobraindev

# Check formula
brew audit --cask nobraindev

# View formula
brew cat nobraindev

# Check for updates
brew livecheck nobraindev
```

## Release Workflow

### Automated (Recommended)
1. Main repo: Create release with `.dmg` files
2. GitHub Actions automatically updates this repo
3. Users: `brew upgrade nobraindev`

### Manual
1. Main repo: Create release with `.dmg` files
2. Run `./update-cask.sh <version>` or use GitHub Actions manual trigger
3. Update `Casks/nobraindev.rb` with the output
4. Test and push changes
5. Users: `brew upgrade nobraindev`

That's it! 🎉

## 📁 Files in This Repository

- **`.github/workflows/update-cask.yml`** - GitHub Actions workflow for automated updates
- **`update-cask.sh`** - Local script for manual updates and testing
- **`Casks/nobraindev.rb`** - The Homebrew cask formula
- **`MAINTENANCE.md`** - This guide

