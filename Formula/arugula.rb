# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.7"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.7/arugula-0.70.7-x86_64-apple-darwin.tar.gz"
      sha256 "54db67f30e55a9c8bcb8c11cd91915fc2ef72bf77177bc5149ed116fc95f6a12"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.7/arugula-0.70.7-aarch64-apple-darwin.tar.gz"
      sha256 "6ded166585b050c3ad864d7d3562f456264d164ab3bc2ddf063170a5ced9ac1e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.7/arugula-0.70.7-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f5eb6b2984e38d303bee02cc51f9a430988eccc8ef5c8ec0ad7c330f3d80af08"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.7/arugula-0.70.7-aarch64-unknown-linux-musl.tar.gz"
      sha256 "63ae3bf158ded363efeb68c52c0c71b0d947dff470bd818bcd7ace5ad645c118"
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
