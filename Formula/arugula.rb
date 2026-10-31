# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.3/arugula-0.66.3-x86_64-apple-darwin.tar.gz"
      sha256 "b287ab6d92b716dd6d802522109a45356365622a3b0a62331c8b3c6063b571fd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.3/arugula-0.66.3-aarch64-apple-darwin.tar.gz"
      sha256 "7b93d14312779d23dbeac83871860ad2875348fa97675be4ecd5a58ab0be54ee"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.3/arugula-0.66.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "03da4b7f6fb4399329402be61b18206db6d9d93597e9b391f03a2b5bc72db141"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.3/arugula-0.66.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "25f7948bf72d105f0d5debf2183efd877190210641c290b3348f472d5a428141"
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
