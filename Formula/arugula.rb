# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.114"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.114/arugula-0.70.114-x86_64-apple-darwin.tar.gz"
      sha256 "12f2baeee55fd436e763d978b2199bbed9e73c2035149ecba0803be699691abb"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.114/arugula-0.70.114-aarch64-apple-darwin.tar.gz"
      sha256 "f4460c2004d035aada3fa8288ccd262b3c7a966d1a8f0a1b066d0688a0caaec1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.114/arugula-0.70.114-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e4d007378f58ff0ede8d1c7843e3697b599796f87fef66c1f373fcaa7be8b28f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.114/arugula-0.70.114-aarch64-unknown-linux-musl.tar.gz"
      sha256 "94c0b47ddabc91ce08ff80d55cd74cd739fe4737ff51c1c9e268b1e55ed61774"
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
