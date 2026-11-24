# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.95"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.95/arugula-0.70.95-x86_64-apple-darwin.tar.gz"
      sha256 "97f097125aaec339a86da1a857426fbc0e86a2273abde0f005aab443d6d22ccb"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.95/arugula-0.70.95-aarch64-apple-darwin.tar.gz"
      sha256 "0d2217b3fbcfa6655fa0f69c7f95f4d956be3c1483746858c12be583ca08fadf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.95/arugula-0.70.95-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d5a02bd9723ee0813ab823fa6e5dbabf1a405cad7bffbd3de66119b2b975b06e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.95/arugula-0.70.95-aarch64-unknown-linux-musl.tar.gz"
      sha256 "03b15cced703aff0eb69d62ba26fa3ce437ad9abd487eadba14dd17a1ecb2b37"
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
