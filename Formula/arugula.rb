# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.63.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.1/arugula-0.63.1-x86_64-apple-darwin.tar.gz"
      sha256 "1c6d188435230d3e82aa50059dcc769ca86a75e7307e8384c858a1d62d5e37af"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.1/arugula-0.63.1-aarch64-apple-darwin.tar.gz"
      sha256 "5f76bd0eb76d3ee17d7d24cf24982def526ca4c7492a9d5a0024046ac9767ef0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.1/arugula-0.63.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "789f2d1d3b0a306f047fd063d1750cbc7abe2cab5760739ee24715078998d62a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.1/arugula-0.63.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9a9f176eb7daceb14e7ee4e3ab0e0d04b886633feebf9236bee1be596b90569b"
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
