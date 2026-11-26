# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.128"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.128/arugula-0.70.128-x86_64-apple-darwin.tar.gz"
      sha256 "ae24558472990c828ffbdab401f669efaa8aba19190f748359da889bc9433f10"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.128/arugula-0.70.128-aarch64-apple-darwin.tar.gz"
      sha256 "114ffa4b38f7a0ab36c21991b0af71d2e3b3fa8ac781eb557389683b79dd165a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.128/arugula-0.70.128-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c779fec6b97db05fdd371e8c0994c737baca02ed00620d6c2b8b0c670d826655"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.128/arugula-0.70.128-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e51ddf56ca9c5789ca58723b3142027f4b0deabdcc595cb970eec6595e44c753"
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
