# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.0/arugula-0.70.0-x86_64-apple-darwin.tar.gz"
      sha256 "5e3bdc01cd1d241dc6c86c0aeaf316822945d0ae43513bdb9fc6f2fc1beb97f6"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.0/arugula-0.70.0-aarch64-apple-darwin.tar.gz"
      sha256 "cc1bccac8b2547976d89f28c8b476f6a23f4c3ae2affd958db45c07c44fe5510"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.0/arugula-0.70.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a354390815df1d3751a60f79d0639f0dc1d2876d7d78b9346296d515428a4f5c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.0/arugula-0.70.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a76cb40b531f90eaba2dfd0bbadaf1cf35f40c1842313128cc7791601b0e17c0"
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
