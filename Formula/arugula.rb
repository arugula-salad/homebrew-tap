# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.147"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.147/arugula-0.70.147-x86_64-apple-darwin.tar.gz"
      sha256 "f0a18580b22a946438821e3909f10ed4d75415be2cdf008744ffda76106dffe1"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.147/arugula-0.70.147-aarch64-apple-darwin.tar.gz"
      sha256 "a749e73dce2d5f2b30b18d2729129400398951baedda7d88f755dd33e14021bf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.147/arugula-0.70.147-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9d771a2dee00ef42a84611b2657120705e622a550641402df98be960f3c5d7ac"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.147/arugula-0.70.147-aarch64-unknown-linux-musl.tar.gz"
      sha256 "57001cc6e7b9dca56e4adcbc195ef8eba0afd4d5ef5cf03abb473f565bc1b61e"
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
