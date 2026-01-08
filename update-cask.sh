#!/bin/bash

# Script to automate NoBrainDev Homebrew cask updates
# Usage: ./update-cask.sh <version>
# Example: ./update-cask.sh 0.2.6

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if version argument is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: Version number required${NC}"
    echo "Usage: $0 <version>"
    echo "Example: $0 0.2.6"
    exit 1
fi

VERSION="$1"
REPO_URL="https://github.com/techbruwh/nobraindev/releases/download"
TEMP_DIR=$(mktemp -d)

echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  NoBrainDev Homebrew Cask Update Script   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Version: ${VERSION}${NC}"
echo ""

# Function to cleanup temp files
cleanup() {
    echo -e "\n${YELLOW}Cleaning up temporary files...${NC}"
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# Step 1: Download DMG files
echo -e "${BLUE}[1/3] Downloading DMG files...${NC}"
cd "$TEMP_DIR"

AARCH64_FILE="NoBrainDev_${VERSION}_aarch64.dmg"
X64_FILE="NoBrainDev_${VERSION}_x64.dmg"

AARCH64_URL="${REPO_URL}/v${VERSION}/${AARCH64_FILE}"
X64_URL="${REPO_URL}/v${VERSION}/${X64_FILE}"

echo -e "  → Downloading ${AARCH64_FILE}..."
if ! curl -L -f -o "$AARCH64_FILE" "$AARCH64_URL" 2>/dev/null; then
    echo -e "${RED}Error: Failed to download ${AARCH64_FILE}${NC}"
    echo -e "${RED}URL: ${AARCH64_URL}${NC}"
    echo -e "${YELLOW}Please verify the release exists on GitHub${NC}"
    exit 1
fi
echo -e "  ${GREEN}✓ Downloaded ${AARCH64_FILE}${NC}"

echo -e "  → Downloading ${X64_FILE}..."
if ! curl -L -f -o "$X64_FILE" "$X64_URL" 2>/dev/null; then
    echo -e "${RED}Error: Failed to download ${X64_FILE}${NC}"
    echo -e "${RED}URL: ${X64_URL}${NC}"
    echo -e "${YELLOW}Please verify the release exists on GitHub${NC}"
    exit 1
fi
echo -e "  ${GREEN}✓ Downloaded ${X64_FILE}${NC}"

# Step 2: Calculate SHA256 checksums
echo -e "\n${BLUE}[2/3] Calculating SHA256 checksums...${NC}"

AARCH64_SHA=$(shasum -a 256 "$AARCH64_FILE" | awk '{print $1}')
X64_SHA=$(shasum -a 256 "$X64_FILE" | awk '{print $1}')

echo -e "  ${GREEN}✓ aarch64 SHA256: ${AARCH64_SHA}${NC}"
echo -e "  ${GREEN}✓ x64 SHA256:     ${X64_SHA}${NC}"

# Step 3: Generate output for cask file
echo -e "\n${BLUE}[3/3] Generating cask update...${NC}"
echo ""
echo -e "${GREEN}════════════════════════════════════════════${NC}"
echo -e "${GREEN}Update Casks/nobraindev.rb with:${NC}"
echo -e "${GREEN}════════════════════════════════════════════${NC}"
echo ""
cat << EOF
cask "nobraindev" do
  version "${VERSION}"

  on_arm do
    sha256 "${AARCH64_SHA}"

    url "https://github.com/techbruwh/nobraindev/releases/download/v#{version}/NoBrainDev_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "${X64_SHA}"

    url "https://github.com/techbruwh/nobraindev/releases/download/v#{version}/NoBrainDev_#{version}_x64.dmg"
  end

  name "NoBrainDev"
  desc "AI-powered code snippet manager with semantic search"
  homepage "https://github.com/techbruwh/nobraindev"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "NoBrainDev.app", target: "No Brain Dev.app"

  zap trash: [
    "~/.local/share/nobraindev",
    "~/Library/Application Support/com.techbruwh.nobraindev",
    "~/Library/Caches/com.techbruwh.nobraindev",
    "~/Library/Preferences/com.techbruwh.nobraindev.plist",
  ]
end
EOF
echo ""
echo -e "${GREEN}════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo -e "  1. Copy the above content to ${BLUE}Casks/nobraindev.rb${NC}"
echo -e "  2. Test: ${BLUE}brew audit --cask --strict techbruwh/nobraindev/nobraindev${NC}"
echo -e "  3. Test: ${BLUE}brew style --fix Casks/nobraindev.rb${NC}"
echo -e "  4. Test: ${BLUE}brew reinstall nobraindev${NC}"
echo -e "  5. Commit: ${BLUE}git add Casks/nobraindev.rb && git commit -m \"Update NoBrainDev to v${VERSION}\"${NC}"
echo -e "  6. Push: ${BLUE}git push origin main${NC}"
echo ""
echo -e "${GREEN}✓ Done!${NC}"

