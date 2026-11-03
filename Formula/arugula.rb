# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.15"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.15/arugula-0.66.15-x86_64-apple-darwin.tar.gz"
      sha256 "f7285e97f09ac4efc932709ed4ddef77cbd95e29eabbda16f8dfefe72b2364dd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.15/arugula-0.66.15-aarch64-apple-darwin.tar.gz"
      sha256 "6f90d9f16d0659224dfe30bcdff67731177216c22e3fc92ab5eaca0296c7d8bd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.15/arugula-0.66.15-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d8952702ef87998997098c25ea78cfa1a5031eb14bedbe4a037010057bccfa92"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.15/arugula-0.66.15-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f18bfe2586e29b7bfd28a48a7d6c133d1c92d5756bd946c85d7062d3c2d91068"
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
