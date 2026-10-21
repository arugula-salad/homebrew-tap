# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.54.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.54.1/arugula-0.54.1-x86_64-apple-darwin.tar.gz"
      sha256 "13ba4a7729323167a93791c9f8623a33b42e51fb9d19d824584b909c4848534d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.54.1/arugula-0.54.1-aarch64-apple-darwin.tar.gz"
      sha256 "2ee09ad69004bcd1c31242c30981e3556d2d42d62c589c065c52376070c1849e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.54.1/arugula-0.54.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "73c46bd194b7bd3280bfaa14a9dc28dbbb83d130861e2ae11cab17498e15c0c7"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.54.1/arugula-0.54.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "61e0f8d281e00a0fc6408891a3988c69956d62811b8cc8d7e4c9d1892c76332e"
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
