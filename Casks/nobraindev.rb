cask "nobraindev" do
  version "0.1.0"
  
  arch arm: "aarch64", intel: "x64"

  url "https://github.com/techbruwh/nobraindev/releases/download/v#{version}/NoBrainDev_#{version}_#{arch}.dmg",
      verified: "github.com/techbruwh/nobraindev/"
  sha256 arm:   "9e2476ac2bcca850621984a494336b2569749e104f0d639b785462ff762cf571",
         intel: "674307eae2572332a2edde06011125f51b8763ed5fddfa16a0e1a43946c2cb79"
  
  name "NoBrainDev"
  desc "AI-powered code snippet manager with semantic search"
  homepage "https://github.com/techbruwh/nobraindev"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "NoBrainDev.app"

  zap trash: [
    "~/Library/Application Support/com.techbruwh.nobraindev",
    "~/Library/Caches/com.techbruwh.nobraindev",
    "~/Library/Preferences/com.techbruwh.nobraindev.plist",
    "~/.local/share/snippet-vault",
  ]
end

