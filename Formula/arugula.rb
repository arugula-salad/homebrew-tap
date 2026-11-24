# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.100"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.100/arugula-0.70.100-x86_64-apple-darwin.tar.gz"
      sha256 "4d49fa9e9e8d6fea56cc04c37ba929e3ed6d1de4f418be56dde4d1fe42c4c317"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.100/arugula-0.70.100-aarch64-apple-darwin.tar.gz"
      sha256 "3bc204e7c1b3c7066838cf3c00393a755f91134a32d110add949681336ea38eb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.100/arugula-0.70.100-x86_64-unknown-linux-musl.tar.gz"
      sha256 "02d24d274ed5d5d6c447789b9fb029668322681441207df6de01260e09f71e7e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.100/arugula-0.70.100-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cbffbb9bf001b21e925165f033aea6810331411f906eb5cc0dc28e688ea02229"
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
