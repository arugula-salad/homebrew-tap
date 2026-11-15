# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.13"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.13/arugula-0.70.13-x86_64-apple-darwin.tar.gz"
      sha256 "8aef1d60f9286d1765b6293cf4548e417b87f82fef3c94a4a3a79b1b303323b1"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.13/arugula-0.70.13-aarch64-apple-darwin.tar.gz"
      sha256 "19e6054a695f55e21d3b92c0bb7fa6044800b9e519b9fcbc54516da777186c74"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.13/arugula-0.70.13-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e7fca6a9b5f688d2313b6bc32f45a840aaf9b53d517a2a8da6a12f5ae357cd6f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.13/arugula-0.70.13-aarch64-unknown-linux-musl.tar.gz"
      sha256 "963cdcbf161a9d6faac6acf99130d6efedcc91ddad0714ab704659598dbb4c07"
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
