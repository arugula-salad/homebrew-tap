# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.12"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.12/arugula-0.66.12-x86_64-apple-darwin.tar.gz"
      sha256 "d82dba2ab698d8a1f07e1afe89e0a46213ecd0f2ab752a3fcc20fe6d7c07fdc8"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.12/arugula-0.66.12-aarch64-apple-darwin.tar.gz"
      sha256 "939f952c04e9d971a550640d5be754b783f580980ef869be840fb6f76c90c48f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.12/arugula-0.66.12-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e0c2f5931d88785e7f7269e6b1d7b1152377192e1d0257d84d5b430547f51159"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.12/arugula-0.66.12-aarch64-unknown-linux-musl.tar.gz"
      sha256 "73731d8a8e1f4604858c891cf6d3162d779774ed8254c51f226740dd8eb25c64"
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
