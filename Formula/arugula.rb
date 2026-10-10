# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.31.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.31.1/arugula-0.31.1-x86_64-apple-darwin.tar.gz"
      sha256 "c7a381e49277dc094aa385b3e33bf4b4cd514e8700b66a90dc12ee000736c715"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.31.1/arugula-0.31.1-aarch64-apple-darwin.tar.gz"
      sha256 "cc0dbbeb1a99fc2ba53a32f3db3c6f03c82a23f2e21ca289697a3775ad0228ab"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.31.1/arugula-0.31.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "840f48f5324d4fcd053713a4d52f5f7298eba25e215661e465998cf0059a3f5f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.31.1/arugula-0.31.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c44ce2ae9d593a1e5741f71004cd1ff15dfec5dec9d476fd42ab41ddf5cc925e"
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
