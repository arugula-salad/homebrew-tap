# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.20"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.20/arugula-0.60.20-x86_64-apple-darwin.tar.gz"
      sha256 "efbd94d1272d8847950a79550b4f7d49e3c0a3cfbcd0e656b74837e710badf97"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.20/arugula-0.60.20-aarch64-apple-darwin.tar.gz"
      sha256 "c5e7c9bcadfa0e704e6ff0256db899136424c8e31be7caafc236c12ec2806c16"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.20/arugula-0.60.20-x86_64-unknown-linux-musl.tar.gz"
      sha256 "757d542915dad30467a62f2fe49544255ba427ef90d58159308d6f7a76ec1e8a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.20/arugula-0.60.20-aarch64-unknown-linux-musl.tar.gz"
      sha256 "649c7a1e1e1c85de35f3a0689e91a95b74cb528984878bcb0d97a9ed06f9129d"
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
