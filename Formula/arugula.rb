# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.6"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.6/arugula-0.66.6-x86_64-apple-darwin.tar.gz"
      sha256 "863646e2decefdac37b4cbf08687b5cdf8bb9900a7e0859da7d0b57fdf8b0f24"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.6/arugula-0.66.6-aarch64-apple-darwin.tar.gz"
      sha256 "be1fa187b66cf13d0abe59925abad6372247fd7c18ff84088b163252f64bf10c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.6/arugula-0.66.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "19787ac884a0c429197a8c47872a0ac80f863ac4a490e0d4b0739e074d110d5e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.6/arugula-0.66.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "acb2cec9152ce0d29ba8495c43999650b1b01afb12b4acfc032f5bb1720cc6cf"
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
