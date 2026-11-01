cask "tuck" do
  version "0.1.0"
  sha256 "596724c3a6d9833500a2701319700c590a9cf10c5c223c42168910fb1b84161c"

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
