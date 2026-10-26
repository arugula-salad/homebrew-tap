# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.62.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.62.1/arugula-0.62.1-x86_64-apple-darwin.tar.gz"
      sha256 "7ccac7cc7cf32bebf92731c1111f4b26f967abbb006e70be4176390f198fd54e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.62.1/arugula-0.62.1-aarch64-apple-darwin.tar.gz"
      sha256 "c9f436620db94033712abb9c60f5142a7a5e50c1efce879b3a25c2b16f66c4e9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.62.1/arugula-0.62.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0dabed53e54ded3d45be701c7cfb50e37b5212997bfc433fbef056a35851e937"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.62.1/arugula-0.62.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5feb0df403a6cc8714c45b1da2adc5836546fed1a8bb1b6477bb65c0ce1c262f"
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
