# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.21"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.21/arugula-0.69.21-x86_64-apple-darwin.tar.gz"
      sha256 "868fdc3955d34251ded157b68aa028c4b758e6ea0867cde1bf1621f211cdc8c6"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.21/arugula-0.69.21-aarch64-apple-darwin.tar.gz"
      sha256 "eaadc501b811576979c9cea5e146b3d1231a997b9322074434744b9c768eac2d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.21/arugula-0.69.21-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1b249b73a7d8a42fa6938de5546d43ddd6b6bea516d5187fd07df2c1237ec86a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.21/arugula-0.69.21-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ded6e10ad4e4366306fc4e5f97d1ee64298d134e69589859eb9b6f368f2e93e1"
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
