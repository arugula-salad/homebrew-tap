# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.65"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.65/arugula-0.70.65-x86_64-apple-darwin.tar.gz"
      sha256 "23d9ddd6b2b064d1d544860653ea4b5c6142bc952955dda110eb3b780fcca8a9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.65/arugula-0.70.65-aarch64-apple-darwin.tar.gz"
      sha256 "c9165a21cf209e7db3fdf5c4d3a4ed530c75a7f97e78bd3f6dfa272ef899d33b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.65/arugula-0.70.65-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5687e3088b26f6dd9f9a9e23e09ce825aff364b7ea61e1043e021af321708e37"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.65/arugula-0.70.65-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0c907396f65200429e22c59a9586ed2bb563e35de117c5e58fa0d335384dc2c0"
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
