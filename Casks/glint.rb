cask "glint" do
  version "0.2.0"
  sha256 "e9aa4a5e7dce7b598c38dec3dadbd4d4affaa50e4013a79de162558f1a6f6f46"

  url "https://github.com/jxu-dev-c/glint/releases/download/v#{version}/Glint-#{version}.zip"
  name "Glint"
  desc "Menu bar control for display brightness, resolution and HDR"
  homepage "https://github.com/jxu-dev-c/glint"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Glint.app"

  # signed ad hoc, not notarized
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Glint.app"],
                          writable_paths: ["Glint.app"], writable_base: :appdir
  end

  uninstall quit: "com.jasonxu.glint"

  zap trash: "~/Library/Preferences/com.jasonxu.glint.plist"
end
