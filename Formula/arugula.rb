# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.94"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.94/arugula-0.70.94-x86_64-apple-darwin.tar.gz"
      sha256 "3ba7f9b29f3354bb2f3ede7ab4b43e12c0aa2f2d74002a7b001a426e1a8488cd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.94/arugula-0.70.94-aarch64-apple-darwin.tar.gz"
      sha256 "1d9ab90e6856dbf07bc67016da0792eca35acc79770e64a93cf321b9f9f3c766"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.94/arugula-0.70.94-x86_64-unknown-linux-musl.tar.gz"
      sha256 "153210fdc7cb08931e842303478195cd258d6f91cffeb8ddeb3b7b945dfc8252"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.94/arugula-0.70.94-aarch64-unknown-linux-musl.tar.gz"
      sha256 "215620d3d4d06f8d45debfcb826a50285767348b633a783419811e467973991e"
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
