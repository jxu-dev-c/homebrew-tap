cask "mjolnir" do
  version "0.1.15-mjolnir.2"
  sha256 "93a85becdf4ccceaed6feda6be002d0a91555bb1edb05925cba95afb2db706ee"

  url "https://github.com/jxu-dev-c/Mjolnir/releases/download/v#{version}/Mjolnir-#{version}.zip"
  name "Mjolnir"
  desc "Desktop app for herdr-core agent terminals"
  homepage "https://github.com/jxu-dev-c/Mjolnir"

  depends_on arch: :arm64
  depends_on :macos

  app "Mjolnir.app"
  binary "#{appdir}/Mjolnir.app/Contents/MacOS/Mjolnir", target: "herdr-app"

  # signed with a self-signed identity, not notarized
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Mjolnir.app"],
                          writable_paths: ["Mjolnir.app"], writable_base: :appdir
  end

  uninstall quit: "com.jasonxu.mjolnir"

  # ~/.config/herdr-app is left alone: upstream Herdr may share it.
  zap trash: "~/Library/Preferences/com.jasonxu.mjolnir.plist"
end
