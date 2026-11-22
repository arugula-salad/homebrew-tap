# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.80"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.80/arugula-0.70.80-x86_64-apple-darwin.tar.gz"
      sha256 "40243f8a236232d57eb42d27799d145b4d58d5d33b116df763ba2c8eab4fd6f9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.80/arugula-0.70.80-aarch64-apple-darwin.tar.gz"
      sha256 "ea1c4e36566741c38392fb29dfa368a8cc8b4dc9553933624f374ac32e434ce7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.80/arugula-0.70.80-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9ba08b20863564ae3e29adf90c36a2828dd2ff3b5bc2e29c858d518c65751ef5"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.80/arugula-0.70.80-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c706311b364861cf0e776da42087d65aba58a0961c062ae4204455d70b0e37fa"
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
