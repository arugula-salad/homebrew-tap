# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.28"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.28/arugula-0.70.28-x86_64-apple-darwin.tar.gz"
      sha256 "fdf19f28f394fb5f72314cf9b0311933f59d6c3d8a57e47ac3026e073399625e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.28/arugula-0.70.28-aarch64-apple-darwin.tar.gz"
      sha256 "8059eb36bc69cf22d48a810a13d2771712895b097a84faca49a3c8ce2cb20751"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.28/arugula-0.70.28-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7788ff50b8d27e8a31a276bdb6e7caf2fbbdf72ec170d042390f8258b197ec03"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.28/arugula-0.70.28-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7510344bc63c9b4eafc62e0190c5ffbf7d13498b56d99ac08b18baa8322845f5"
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
