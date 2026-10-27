# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.63.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.5/arugula-0.63.5-x86_64-apple-darwin.tar.gz"
      sha256 "883f1d9c1bfdec6a82c5370cdad80d255df58147cab32ffb8bc743aa4fa8facc"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.5/arugula-0.63.5-aarch64-apple-darwin.tar.gz"
      sha256 "18140d089b55475f0ab2deb43b85dde490ef9d4bda54f607291cc1aa5b48a764"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.5/arugula-0.63.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "096058cbbaa8e1f72f5827f333ed0f45fc7d438b73d78b3f0d5670d599651226"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.5/arugula-0.63.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3384b5bcb0afa19b3f3a38368a0806cbcdd2ec74001b205874d5fcbec8bb7f88"
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
