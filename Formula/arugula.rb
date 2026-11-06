# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.68.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.4/arugula-0.68.4-x86_64-apple-darwin.tar.gz"
      sha256 "aec6c42ef4d6175cc827acff4b881e2b4d4466e809f98844c1bc47c2dc6335b0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.4/arugula-0.68.4-aarch64-apple-darwin.tar.gz"
      sha256 "6cc4d29cfedb017ed0aeaebe33f37587ae879ce1d7896c7dc4f677cdc7c6cbd7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.4/arugula-0.68.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bf55f51858d3c67d24714fc2b537d0ee068ea089f0a8a622e7e9f9cae5d2bc08"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.4/arugula-0.68.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "11c2354277e95a643c22c9575fa76a0b3b2024724f866c33087e12dfdcd4ffa0"
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
