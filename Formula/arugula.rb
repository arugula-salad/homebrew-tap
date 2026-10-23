# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.7"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.7/arugula-0.60.7-x86_64-apple-darwin.tar.gz"
      sha256 "4e002a9f107799f26924dd29a387bebd8c8c08090b788defe5aaf232ebe20673"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.7/arugula-0.60.7-aarch64-apple-darwin.tar.gz"
      sha256 "40c3a3c4163abdf1fdd4c9116dc9be89d498298bba7c438b3a34378f8d92f136"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.7/arugula-0.60.7-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e8facf751b23b76c9109f54c76189cedabb72be2855c20e8075f058b803de04a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.7/arugula-0.60.7-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e84f0d4d6ace4cf7df77cb4108ceace54cedfbe81f9c4119b606170dd3674a6e"
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
