# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.34.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.34.0/arugula-0.34.0-x86_64-apple-darwin.tar.gz"
      sha256 "31fc66eefe15e0773520bb8e3ca241bbccb2095ea233d99406e65aa66adfd8a0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.34.0/arugula-0.34.0-aarch64-apple-darwin.tar.gz"
      sha256 "e924e546db55a491148d578b38c279cae297bb3d2bf13978323f02607f083fdd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.34.0/arugula-0.34.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a59aaed9df7178fd28f533c3dad16e8832330cfee299114f05e830deaa8a9bfd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.34.0/arugula-0.34.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "69ca441a33412c6500e167fdebb454da088f7bea8d205df5d7eeed14a49a374f"
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
