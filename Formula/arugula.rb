# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.2/arugula-0.69.2-x86_64-apple-darwin.tar.gz"
      sha256 "4594af09d69d557c734d9a9d266eee84053ffd645267272dd5a8dc31867fb9bb"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.2/arugula-0.69.2-aarch64-apple-darwin.tar.gz"
      sha256 "58f5b3ce69e45258c9dc3ceca03081db2a6b107be5e95d955b470046f1aad396"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.2/arugula-0.69.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6db3f792da9feecb00cf9271e224247f5e846100bb0e5352a314c6f99552612a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.2/arugula-0.69.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6d710123490eb738bdbfebb28d77144e528842f15036a3d845b131b2a618e34b"
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
