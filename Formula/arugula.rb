# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.84"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.84/arugula-0.70.84-x86_64-apple-darwin.tar.gz"
      sha256 "384c1fa3fcfa201a6df602edb5ac8d87c165d4fa9ccfac8fb55bd7ee9873f407"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.84/arugula-0.70.84-aarch64-apple-darwin.tar.gz"
      sha256 "f0f592a4f4e38f123539899eae884cb88101a6a22ca4abaa7452b67f7b2ae59a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.84/arugula-0.70.84-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6c5802560d468cd341e6d613c66b9e4d6fd59536858a3df669f2624071fe5c2d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.84/arugula-0.70.84-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8685296e2901835cc6c578991ad68d452cea8d2dd592f1701bf4a899f657f62d"
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
