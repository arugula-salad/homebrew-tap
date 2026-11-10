# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.11"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.11/arugula-0.69.11-x86_64-apple-darwin.tar.gz"
      sha256 "095d03d3a59b6b767cfa89ffa3c32e79bfd8d3278aea48c6c2abc26d12390540"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.11/arugula-0.69.11-aarch64-apple-darwin.tar.gz"
      sha256 "f82530263beb0bf852ee281c27dcbd72de2b1d216175cf5cdecbe2489fdc4bd8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.11/arugula-0.69.11-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ef479b14ba6f251b4376c661ed8d3d76b1f61a45a40c4b952bc451d1bc44a220"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.11/arugula-0.69.11-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0ceaaa007b76877ce7e65e7696c47a0aee2a1067660c4e7f165cde9cd7651de9"
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
