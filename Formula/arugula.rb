# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.90"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.90/arugula-0.70.90-x86_64-apple-darwin.tar.gz"
      sha256 "80f89626f247933bd42666c74c3acba8e72259b743cff93fd356363a97e092da"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.90/arugula-0.70.90-aarch64-apple-darwin.tar.gz"
      sha256 "208a181f0659f42e3940e4416aea95305a4f5407b5564e49bcf126dbe32add6d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.90/arugula-0.70.90-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c930fe34c7411508c87359a59fe7cdd771784c400d45f3d239523f5b0f11dc56"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.90/arugula-0.70.90-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e707da5b10cfd94ad71a0842fdc1762e20a6b2937581ae57625117683d6edfaa"
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
