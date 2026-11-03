# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.13"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.13/arugula-0.66.13-x86_64-apple-darwin.tar.gz"
      sha256 "9098b2de2feafbe14f68cbb75e49a8ad6723abbff0880b92fc9ca60d8e966342"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.13/arugula-0.66.13-aarch64-apple-darwin.tar.gz"
      sha256 "bbd3a190f0bd8d1fae6e88205aeb8667e6c264583673d0bd37ec873e716f98c9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.13/arugula-0.66.13-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a759754ca59a948ca60c0709357fd1615a960530882ceee0934107488c568bd0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.13/arugula-0.66.13-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8b0b354f69996a48ae258496e8471a129235d3987d7b6cc74b58082e08fc27bb"
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
