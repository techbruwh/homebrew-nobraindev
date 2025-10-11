cask "nobraindev" do
  version "0.1.0"

  on_arm do
    url "https://github.com/techbruwh/nobraindev/releases/download/v0.1.0/NoBrainDev_0.1.0_aarch64.dmg",
        verified: "github.com/techbruwh/nobraindev/"
    sha256 "9e2476ac2bcca850621984a494336b2569749e104f0d639b785462ff762cf571"
  end

  on_intel do
    url "https://github.com/techbruwh/nobraindev/releases/download/v0.1.0/NoBrainDev_0.1.0_x64.dmg",
        verified: "github.com/techbruwh/nobraindev/"
    sha256 "674307eae2572332a2edde06011125f51b8763ed5fddfa16a0e1a43946c2cb79"
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
