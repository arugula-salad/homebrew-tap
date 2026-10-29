# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.65.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.1/arugula-0.65.1-x86_64-apple-darwin.tar.gz"
      sha256 "7193b90c310fc9a4c11a25f7892a943ccafab7f97e248c9395fde0c573ea0d31"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.1/arugula-0.65.1-aarch64-apple-darwin.tar.gz"
      sha256 "13a65914dade07177f4d7c6ef42f41bb9b38d1a0a8101df1dce817ee8542ef58"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.1/arugula-0.65.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7ffc4e6a24c74d4da5337b4ff55cfc63209ed08cf76ae634105b40e856a65413"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.1/arugula-0.65.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d3379ef51d6ef18175729757b1c74f10649c89286ce6ed1dcdcc02a361b80600"
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
