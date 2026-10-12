cask "splash-control" do
  version "1.6.0"
  sha256 "a7eb4b277790e343137315e8519badefbb111c727771fad62f425d5eb504bf45"

  name "Splash Control"
  desc "Menu bar controller for the splash LLM server"
  homepage "https://github.com/vlewin/splash-control"

  url "https://github.com/vlewin/splash-control/releases/download/v#{version}/SplashControl-v#{version}.zip"

  depends_on arch: :arm64
  # 26.4 floor per Resources/Info.plist; brew symbols are major-series only.
  depends_on macos: :tahoe
  depends_on formula: "incoai/tap/splash"

  app "Splash.app"

  # App state only. Never touch the engine's trees:
  # Application Support/Splash (models) and Caches/Splash (prefix/weights cache).
  uninstall delete: [
      "~/Library/Application Support/SplashControl",
      "~/Library/Saved Application State/com.vlewin.splash-control.savedState",
  ]

  zap trash: [
      "~/Library/Logs/SplashControl",
  ]

  caveats <<~CAVEATS
    Splash Control is ad-hoc signed and not notarized. macOS will block the
    first open; dismiss it via:

      System Settings -> Privacy & Security -> "Open Anyway"

    If you had "Start at login" enabled, also remove the login item in
    System Settings -> General -> Login Items after uninstalling.
  CAVEATS
end
