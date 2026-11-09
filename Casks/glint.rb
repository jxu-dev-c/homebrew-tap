cask "glint" do
  version "0.1.0"
  sha256 "3c955e4610871a41c78d2b31c418a2f8e275f3de849b8561be614758715c3ee3"

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
