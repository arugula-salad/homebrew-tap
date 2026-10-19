# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.46.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.4/arugula-0.46.4-x86_64-apple-darwin.tar.gz"
      sha256 "1f6d29cb2a146a1402934f95c9cf520214231caa16ed0641cad89fb1f42e530e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.4/arugula-0.46.4-aarch64-apple-darwin.tar.gz"
      sha256 "d211b49c25450c9009294006381f67ac928cfbf29c4042d2541fe21f257abcfd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.4/arugula-0.46.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cb8cc39ca7f8d531c9208cea9d1a8282dee97a15cb60cd31ddbbc6f580401f48"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.4/arugula-0.46.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a4f6ed952a2edc5f767d24104e3c174464198ab5485a941ca252cabeadf93f9c"
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
