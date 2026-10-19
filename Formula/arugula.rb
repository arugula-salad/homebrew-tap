# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.46.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.2/arugula-0.46.2-x86_64-apple-darwin.tar.gz"
      sha256 "5adb9daa756e5e8ba23d0bd2e6dc9aea6647ce38e8fc3ad6025d78c13f3a8b2b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.2/arugula-0.46.2-aarch64-apple-darwin.tar.gz"
      sha256 "306c44edf6996798282d053c8051456d31f63d8c864b878e87281da13af9ab77"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.2/arugula-0.46.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c4f5c147e77fdc305af23bf7a99d6776b08e97d48ab9cf7bec66715679a567e3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.2/arugula-0.46.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c52ece379f2d26150ca3197fa0424f997f24cebfba0d6f3ab089a286278dfe7d"
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
