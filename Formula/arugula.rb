# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.25"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.25/arugula-0.69.25-x86_64-apple-darwin.tar.gz"
      sha256 "7e339f1f423dd251437ee61cf93c990cb9a8bd235665ff5338e6fae255df1eac"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.25/arugula-0.69.25-aarch64-apple-darwin.tar.gz"
      sha256 "8dd9e9e27bd0ecef3a6b6fe038e69f9938bf4548a0f26714bb36ab3cda5f32f2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.25/arugula-0.69.25-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6c8acba6056213c47c66476a1d5169b3d54b5379acc78ac1165cb5729bf46edc"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.25/arugula-0.69.25-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d5145288a7f382f0e017242e55a30998e7e9c9e87f17cb3b4f694092e2f05521"
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
