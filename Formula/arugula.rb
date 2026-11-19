# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.48"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.48/arugula-0.70.48-x86_64-apple-darwin.tar.gz"
      sha256 "8d8a2f6f2f380b19b40413b596ef189e4a020676588dc8e5fd238c26851d6423"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.48/arugula-0.70.48-aarch64-apple-darwin.tar.gz"
      sha256 "a4a1ee7b632be9278bf05a86809621a9ae5ff200bb6eee5f08c831a5fafb7aa0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.48/arugula-0.70.48-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7dc4f9d6e64caf3fa4eb2514e65d34a53df9f860f9e921e4d6e22aed37dcbec2"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.48/arugula-0.70.48-aarch64-unknown-linux-musl.tar.gz"
      sha256 "06f8dc3e8c1144f0839bfcf13ec9471354358d2f8f52b9c23459ca794b34c880"
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
