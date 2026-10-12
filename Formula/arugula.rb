# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.37.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.37.0/arugula-0.37.0-x86_64-apple-darwin.tar.gz"
      sha256 "3316dc13b744cd47ddbcadf323e7d44c6d3f7d5218e6276bf119370c657acf0f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.37.0/arugula-0.37.0-aarch64-apple-darwin.tar.gz"
      sha256 "4388a7dda285b3052a2397706667be022ab4bf52eb31bc9cc931b05cdb03da92"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.37.0/arugula-0.37.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b462ccfcd032732d740e8dc5c9eba463451c05a35088c4eda3c8aa61200ce022"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.37.0/arugula-0.37.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ede52b9588d417bdbe235126c705ac95ffb2be314de12f51a29c5616f567e56c"
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
