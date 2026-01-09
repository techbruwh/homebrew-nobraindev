cask "nobraindev" do
  version "1.0.16"

  on_arm do
    sha256 "8ef4a8073498248a0d494fe654e09d67f397b7a298a7f0735c1d58055bdbab15"

    url "https://github.com/techbruwh/nobraindev/releases/download/v#{version}/NoBrainDev_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "3f1ad404e1e0fd3c27e3b961e461536f863abe361c8dabbb96bc5915e9aaea6b"

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
