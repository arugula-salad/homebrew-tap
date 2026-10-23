# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.9"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.9/arugula-0.60.9-x86_64-apple-darwin.tar.gz"
      sha256 "0417986b89d75b0229ea3b6725435ce69f22a18c71b117eee7625b66efcb1835"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.9/arugula-0.60.9-aarch64-apple-darwin.tar.gz"
      sha256 "3eaf24b7f83f8eb6b29860413e3afac5eb4339e55266bf28187a139c05c00684"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.9/arugula-0.60.9-x86_64-unknown-linux-musl.tar.gz"
      sha256 "96c5cf7fe3d14e99362f903db671f6e5ad6bfc0484677152f808f71dfe09ae89"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.9/arugula-0.60.9-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c79b9db49dd9c23d8c152d1fa65b1ca6dcd5e6abf61faf77ed7d9a42756f8eca"
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
