# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.8"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.8/arugula-0.66.8-x86_64-apple-darwin.tar.gz"
      sha256 "292abd8c7371ece5a27a7bf0be80ad6dca84f711df64c63d2630e9ad3adabd5f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.8/arugula-0.66.8-aarch64-apple-darwin.tar.gz"
      sha256 "716dac4374fd6131795b762728a132540ce0f3441afdf477284ee5759135999c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.8/arugula-0.66.8-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a7fe5c1a4893d12aa7a00913e92cc93ae07f84c17db4bd27d2685933d09a9511"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.8/arugula-0.66.8-aarch64-unknown-linux-musl.tar.gz"
      sha256 "63ad00ecef379f1cee3d88630b6c12e846a23bb894da8390ed7009c9b5f69e4c"
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
