# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.14"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.14/arugula-0.69.14-x86_64-apple-darwin.tar.gz"
      sha256 "52c52405e367ba976c7e757f6f2a07b36fc632382ae9f64f732c087d1a3c05fe"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.14/arugula-0.69.14-aarch64-apple-darwin.tar.gz"
      sha256 "ada4efde7696bef1374433a8c26836412562d7eceddcb29ed28d471bfb5d82f9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.14/arugula-0.69.14-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c51b95e29845542f595adc6a14a79a07d5189a3f7371d237d63b43f8f85fa0aa"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.14/arugula-0.69.14-aarch64-unknown-linux-musl.tar.gz"
      sha256 "35ca7d5dfe9f141699b6dbbc0c64f7dd7b8cddc6274bf2e205ce8becb18e7597"
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
