# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.39.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.2/arugula-0.39.2-x86_64-apple-darwin.tar.gz"
      sha256 "4f4a4680aa5cd7c383b20dafc597db03f0d19ff28421f03ce0837481eae3a348"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.2/arugula-0.39.2-aarch64-apple-darwin.tar.gz"
      sha256 "5ea8cdfceff40d9c14307ead554a4b72a28cc7ebfe7bfa7e418c8d407cb476e3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.2/arugula-0.39.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7c636ee10e73a2a67d000c06b31468d5579c04d07646f3080de8dfddf165dc21"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.2/arugula-0.39.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "02928650805b2b8ec4c6f8d0cbc8230a56b985e547ed18725e7b47a688002e02"
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
