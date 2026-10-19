# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.46.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.3/arugula-0.46.3-x86_64-apple-darwin.tar.gz"
      sha256 "099f23737678b21d8502938a23abda1f7c7a5611a2f0109fbe41ee88782de150"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.3/arugula-0.46.3-aarch64-apple-darwin.tar.gz"
      sha256 "7720d2526d10b072a88f06bb7ee6920f4ca8c0693ef26f78afd5d4b3aef93d33"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.3/arugula-0.46.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a868cd0ee7005202b738a15ad0ce73b21dd8ccd525a77a4936ef71cd4efda951"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.3/arugula-0.46.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d7380a07abe2bf26019f590fc7382def8d6dac2bf42a4b7095ccea1450b55fc2"
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
