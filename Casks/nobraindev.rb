cask "nobraindev" do
  version "2.1.2"

  on_arm do
    sha256 "ab85d22c704566e61d4ace7c3dbfe7ba99f4f600953d0e541100274551b8036f"

    url "https://github.com/techbruwh/nobraindev/releases/download/v#{version}/NoBrainDev_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "f2a84c9d7ab31f9819979010d2e334e71580291b36e7316f1e6da31277734a70"

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
