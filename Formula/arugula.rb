# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.105"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.105/arugula-0.70.105-x86_64-apple-darwin.tar.gz"
      sha256 "f9e9b8a26052da24dbf07314fea6b77f3e68a3c94e8fed743d98de272b2a3abe"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.105/arugula-0.70.105-aarch64-apple-darwin.tar.gz"
      sha256 "81138d80647ff6451ce00ec07d92fd0d74223943d5d09314c5647b76624333e8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.105/arugula-0.70.105-x86_64-unknown-linux-musl.tar.gz"
      sha256 "229a765620efac3c36fbbc22fec75d22d11ed31080f3860f7e806f82b3f993f9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.105/arugula-0.70.105-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ccbe7836e7696ad7430916fc6077bde143856eb78a1dc9c99512ffca116d6411"
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
