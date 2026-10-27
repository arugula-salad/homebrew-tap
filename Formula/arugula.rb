# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.63.6"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.6/arugula-0.63.6-x86_64-apple-darwin.tar.gz"
      sha256 "51e2520bc2f738364aacdb0fdded3d85dae6b5b63e1b0e64bb26a3b406f25a89"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.6/arugula-0.63.6-aarch64-apple-darwin.tar.gz"
      sha256 "c39701a7750451899cae6c5eb64c681c01c61fdf50fc35f96ae0552b61a4464a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.6/arugula-0.63.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ef769bb499885c27c365411c2144fd69f1f6bbb3115c95ab4fed6c4dc3387d08"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.6/arugula-0.63.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "720719e4cf342218b28e4492e8014ea91282c067f08ce4ce97056f99821aadd5"
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
