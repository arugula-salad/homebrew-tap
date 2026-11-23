# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.92"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.92/arugula-0.70.92-x86_64-apple-darwin.tar.gz"
      sha256 "a974dd971d50fa40cb6a07376def2b76048c20695aca370c4f2e5cb4ac691e77"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.92/arugula-0.70.92-aarch64-apple-darwin.tar.gz"
      sha256 "ec45bbefe59360139d81e2194d6acdab4460ddf3b102a5053b823850414465d0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.92/arugula-0.70.92-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5a457385cd1577b8417f37d567763a5a2ab8359e8613a417086e9669f6b46165"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.92/arugula-0.70.92-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6a6cb22046e4d0a3a286bf4ad047b47ac124f8182624d702c03ac5e856651450"
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
