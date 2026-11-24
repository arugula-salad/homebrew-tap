# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.103"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.103/arugula-0.70.103-x86_64-apple-darwin.tar.gz"
      sha256 "61b2ead1dff1fdc450f26d29a8c3b25ee5a29c07520c1405e0908a6a665ba838"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.103/arugula-0.70.103-aarch64-apple-darwin.tar.gz"
      sha256 "68cc1aff601686e76e38b9936a557e0b7d47408534b4fb4b12951383dbcbcb66"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.103/arugula-0.70.103-x86_64-unknown-linux-musl.tar.gz"
      sha256 "84d6d783b793dfd3852a383e9aa51324aae12fc6551f5b5c59aab847c97a5c41"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.103/arugula-0.70.103-aarch64-unknown-linux-musl.tar.gz"
      sha256 "21224a06d557f1788eb823a8b76115e332350cd7d6047d1f86a871f360c0ec1f"
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
