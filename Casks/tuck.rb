cask "tuck" do
  version "0.2.0"
  sha256 "4266c4267fc425455c3fc5159bf4b2ef6062aab26153438c5d2ff598ef8e32c8"

  url "https://github.com/jxu-dev-c/tuck/releases/download/v#{version}/Tuck-#{version}.zip"
  name "Tuck"
  desc "Menu bar manager that hides icons until you need them"
  homepage "https://github.com/jxu-dev-c/tuck"

  depends_on macos: :tahoe

  app "Tuck.app"

  # signed with a self-signed identity, not notarized
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Tuck.app"],
                          writable_paths: ["Tuck.app"], writable_base: :appdir
  end

  uninstall quit: "com.jasonxu.tuck"

  zap trash: "~/Library/Preferences/com.jasonxu.tuck.plist"
end
