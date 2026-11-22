# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.81"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.81/arugula-0.70.81-x86_64-apple-darwin.tar.gz"
      sha256 "942e26ce69be9e45ff977f563592d00eb2a6272a74707e89504b77cbf407bd11"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.81/arugula-0.70.81-aarch64-apple-darwin.tar.gz"
      sha256 "8be99b37e7a948bb4245ce47eef70f9544c3b922f2e2f0422e6fb99766169e1a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.81/arugula-0.70.81-x86_64-unknown-linux-musl.tar.gz"
      sha256 "10c9bc3b4411fb66febdfc56deddf8e0d6433b4b56df048b338cec8609ddfbbc"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.81/arugula-0.70.81-aarch64-unknown-linux-musl.tar.gz"
      sha256 "35d46bbf87b08b149c647917a700cc22391c1889a2297f3c6a06184b3c0dec93"
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
