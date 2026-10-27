# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.63.7"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.7/arugula-0.63.7-x86_64-apple-darwin.tar.gz"
      sha256 "808e8fa994c84579749cacae9c8511f48d5099e0828510c7900259a65a3e52f6"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.7/arugula-0.63.7-aarch64-apple-darwin.tar.gz"
      sha256 "6f985dc42b9ed782bf28fd03700a7f9443149f92a29b9fffddfdaa9c054833eb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.7/arugula-0.63.7-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ba9d9b8d91bb766f9bb27bfb8ce07db830aaa4d0a1e1c8fcb288891cc92d717f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.7/arugula-0.63.7-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c21a5420eabe487e6ef2fedd3f7a30c77b3ab0284f6476688e64189b42b0f641"
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
