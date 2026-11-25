# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.113"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.113/arugula-0.70.113-x86_64-apple-darwin.tar.gz"
      sha256 "f046fec9447d886c6e1d5796e0a52f5c024b96d5678172b4ca037cf4b1618e37"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.113/arugula-0.70.113-aarch64-apple-darwin.tar.gz"
      sha256 "61e157326b55218961965ceb18c47b80b53b28ae56a4f00d75b23b58c88e7a80"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.113/arugula-0.70.113-x86_64-unknown-linux-musl.tar.gz"
      sha256 "af416de4d4869ae267d93318e04251d337dc9afbb71bc46d170286a9c39fefd8"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.113/arugula-0.70.113-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d6dcf5e1c6729b663bee8d850576cd45162874346b4c76dfae7c6607d83cc154"
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
