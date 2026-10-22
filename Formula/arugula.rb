# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.59.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.59.0/arugula-0.59.0-x86_64-apple-darwin.tar.gz"
      sha256 "75f3c09d4604a45744d3d1a716da234ad2ff591a32acceb8f79906faada4178e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.59.0/arugula-0.59.0-aarch64-apple-darwin.tar.gz"
      sha256 "611de484bff062443667f813da9dc29c6481a8febc4ef1990a129a15eafba871"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.59.0/arugula-0.59.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4c5712b18e3fe8c95bb7da7e06d2774ed51d785b099e40907a442b3ece0ea376"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.59.0/arugula-0.59.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1a1452d2e06d0671d4a46b7ebcbbf5069ea3c4dd1a6d6b071473d66059700ad4"
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
