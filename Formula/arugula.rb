# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.82"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.82/arugula-0.70.82-x86_64-apple-darwin.tar.gz"
      sha256 "dc93c9012e4226f718d6d8ec6977f6c3e7bbb85b871bb4d4892e03716dda6790"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.82/arugula-0.70.82-aarch64-apple-darwin.tar.gz"
      sha256 "0497e0a58b608ca78531a4eb989cdcd2e2a01ad7ed394d757d8a47334991b712"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.82/arugula-0.70.82-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a2eeb3069baa8c254015104ca993415e6b9d9dc292856bdadea4979712c3f864"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.82/arugula-0.70.82-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4b237eb9c2fcc50f76b794304eaea8a10d08927610fa09d1ac6985c689393c35"
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
