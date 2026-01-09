cask "nobraindev" do
  version "1.0.14"

  on_arm do
    sha256 "4fb37bb4f93765f9d4522739d9806953605ea2a4b7accec3405a1e906f97d716"

    url "https://github.com/techbruwh/nobraindev/releases/download/v#{version}/NoBrainDev_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "6f8a77cb67e720280d4439e9917c5301fdb730a9cd873e8688ae8a4a80ded3e5"

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
