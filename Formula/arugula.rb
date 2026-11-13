# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.3/arugula-0.70.3-x86_64-apple-darwin.tar.gz"
      sha256 "b5338a792e79cbbed3155c8475d436cd40330bfc0db4770069b877a646ac109d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.3/arugula-0.70.3-aarch64-apple-darwin.tar.gz"
      sha256 "0ab638a33ebdb585a2a5a5393c734bdf6ffa4ac2d79ad11837ceb5a1b47c6cc5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.3/arugula-0.70.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "08025f3e24d6d873caf832b25fbe9ea0ce7b90d8fdc80477936003b500f08704"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.3/arugula-0.70.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d942cb5c656de943e2ac6b92f78953740c48bb06346c28a1c791e4c9544f0811"
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
