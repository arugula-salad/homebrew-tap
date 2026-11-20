# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.63"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.63/arugula-0.70.63-x86_64-apple-darwin.tar.gz"
      sha256 "6e4055ee59719c799ebd6ec98c2988d8407b6c9d103dc004bb31860273a808ee"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.63/arugula-0.70.63-aarch64-apple-darwin.tar.gz"
      sha256 "25a748e79eae3e4002746be3ff4f111ec9ced183931581ac9698e575c107abb5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.63/arugula-0.70.63-x86_64-unknown-linux-musl.tar.gz"
      sha256 "490575765602c5d3fb82634d73fac1bf76f55e05b5eac66cf5b550563d9146a3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.63/arugula-0.70.63-aarch64-unknown-linux-musl.tar.gz"
      sha256 "02b9bf885027aca402a410d7f10de943df1fd59be7221ee04b1b00da5af3df37"
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
