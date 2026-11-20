# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.56"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.56/arugula-0.70.56-x86_64-apple-darwin.tar.gz"
      sha256 "f6de3e53cf7f720c270dae1d3db1fcba33a3f94c9581fd3fcccfb028f5b25d69"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.56/arugula-0.70.56-aarch64-apple-darwin.tar.gz"
      sha256 "c8b50a910586497dc201304da7b185282bd93e9540cd62da5e7fcbb384a8bd66"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.56/arugula-0.70.56-x86_64-unknown-linux-musl.tar.gz"
      sha256 "45bce908ae97fb73dc1e7924626326f70230f7668306e951559aada185c9e72c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.56/arugula-0.70.56-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a19cac0dd40a6aa50d8eef5c856347bef81a48a431a569dd04da736cf51c7167"
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
