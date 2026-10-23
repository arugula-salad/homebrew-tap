# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.2/arugula-0.60.2-x86_64-apple-darwin.tar.gz"
      sha256 "2a2fd46315e72298a4b3a86c8969205f40b4b395e165c81d6082bd992c788453"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.2/arugula-0.60.2-aarch64-apple-darwin.tar.gz"
      sha256 "5d9864c96e21c8a3265f703366baacb1e344b4aff787611306b4120f65d5bcae"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.2/arugula-0.60.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "53824e2d0278fb8158947572f87b2fe9400fb80cbd8a8938959667118a0a3222"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.2/arugula-0.60.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1e84dc73e410b78268d8764b154451461b34446639c767a9fc72f2509adf66c9"
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
