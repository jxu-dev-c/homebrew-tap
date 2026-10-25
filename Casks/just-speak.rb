cask "just-speak" do
  version "0.1.1"
  sha256 "af07d562ed896a027ae4566dc98ea3e67d6e0d10c488b24ca876cab6b083a0b5"

  url "https://github.com/jxu-dev-c/just-speak/releases/download/v#{version}/JustSpeak-#{version}.zip"
  name "just-speak"
  desc "On-device voice dictation: hold a key, speak, release"
  homepage "https://github.com/jxu-dev-c/just-speak"

  depends_on arch: :arm64
  depends_on formula: "uv"
  depends_on macos: :sonoma

  app "JustSpeak.app"
  binary "#{appdir}/JustSpeak.app/Contents/MacOS/just-speak"

  # signed with a self-signed identity, not notarized
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/JustSpeak.app"],
                          writable_paths: ["JustSpeak.app"], writable_base: :appdir
  end

  uninstall quit: "dev.just-speak.app"

  zap trash: [
    "~/.config/just-speak",
    "~/Library/Application Support/just-speak",
    "~/Library/Logs/just-speak.log",
  ]

  caveats <<~EOS
    Download the speech model once (~1 GB):
      just-speak setup

    For the rewrite step, add your Inception API key:
      mkdir -p ~/.config/just-speak
      echo 'INCEPTION_API_KEY=...' > ~/.config/just-speak/.env && chmod 600 ~/.config/just-speak/.env

    Then open JustSpeak and grant Microphone and Accessibility when asked.
  EOS
end
