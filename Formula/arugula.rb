# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.62"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.62/arugula-0.70.62-x86_64-apple-darwin.tar.gz"
      sha256 "340452af47d6f81f4b88758db55d8a084a4f8fd4c2e7f4a07ec5a56d119f2694"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.62/arugula-0.70.62-aarch64-apple-darwin.tar.gz"
      sha256 "8dcc878743ec9b72505f4a2224a51443cae7bd606c256b99cd7769ff121112cb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.62/arugula-0.70.62-x86_64-unknown-linux-musl.tar.gz"
      sha256 "186b1797c34118932ae4de632e135fcb2e0d5a041f891259127a55648dbef4e2"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.62/arugula-0.70.62-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f83f4582ec6ff14043efe4f5f61b2acb9637a011b09afa919ad32db816b41471"
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
