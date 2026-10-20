# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.53.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.53.0/arugula-0.53.0-x86_64-apple-darwin.tar.gz"
      sha256 "f2e50e0a00301da9121e9ad3753366d8099d1c416bca8f58bc89a4e6fe7cba6d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.53.0/arugula-0.53.0-aarch64-apple-darwin.tar.gz"
      sha256 "1ac1ab101982da13ab1eca76fb76292bcdc6f20e72f450930bf7cf400e7208b4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.53.0/arugula-0.53.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a7b5ee07b9bcd90e5c4255c6e73c5d5b56b60eab1f472a74fb670eebc20b82bd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.53.0/arugula-0.53.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "da11ac9f5a724e9291dc73dba3b8a7309d371b08e8552b03207cecaf139a5d59"
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
