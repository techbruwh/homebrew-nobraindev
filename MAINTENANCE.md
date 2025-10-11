# Tap Maintenance Guide

Quick guide for updating the Homebrew tap when releasing new versions.

## Updating for New Release

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
brew audit --cask --strict Casks/nobraindev.rb

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

1. Main repo: Create release with `.dmg` files
2. This repo: Update cask with new version + SHA256
3. Push changes
4. Users: `brew upgrade nobraindev`

That's it! 🎉

