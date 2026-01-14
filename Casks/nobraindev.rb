cask "nobraindev" do
  version "1.3.6"

  on_arm do
    sha256 "ab8405d44bcb67a1091b89902829eb360c3e1eeea2580e48268a374e92b336a4"

    url "https://github.com/techbruwh/nobraindev/releases/download/v#{version}/NoBrainDev_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "13ccb8baa9a691d4aa7b2d66914ad3ecc219257d618dca747e7368b12daabbdc"

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
