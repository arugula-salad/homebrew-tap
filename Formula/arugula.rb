# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.68.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.1/arugula-0.68.1-x86_64-apple-darwin.tar.gz"
      sha256 "650ef4c45ddd83991e9408ee1ae2eaf8c3d19646479d8348d2ee92304390ea52"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.1/arugula-0.68.1-aarch64-apple-darwin.tar.gz"
      sha256 "12824fae8884305786614a9d1aefd76d362064a804184f77d1fd002fbce8d617"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.1/arugula-0.68.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ba42773d67eba53477fd60873e9edc7a14c69fb2d31690985c6182a5bbef0ae0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.1/arugula-0.68.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7efc2d90b51a95e1d03b99e845d4c1fa0a25e34d45f7e4904d75e6a60df4c3cd"
    end
  end

  def install
    bin.install "arugulad", "arugula"
  end

  def caveats
    <<~EOS
      Start the daemon as a service (a launchd agent on macOS, a systemd
      user unit on Linux), and again after each upgrade:
        arugulad install
      It copies itself to ~/.local/bin, runs from there, and prints the
      next steps: where to open it, its logs, your phone (Tailscale) and
      Arugula control. Then, for Claude Code:
        claude mcp add arugula -- arugula mcp
      Docs: https://arugula.io/#install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/arugulad --version")
  end
end
