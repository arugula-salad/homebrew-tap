# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.63.8"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.8/arugula-0.63.8-x86_64-apple-darwin.tar.gz"
      sha256 "ae490c560ecf4ca065dd1be344f1682ba3843a44fd52db252ca0d0b97989566b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.8/arugula-0.63.8-aarch64-apple-darwin.tar.gz"
      sha256 "f77431e16b006185e2b3074db5539a2f1355f3a1c24e08958232b642ac83dd82"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.8/arugula-0.63.8-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e372205f7ba0db41a5c05b8a78a3b4d3ac5e02023481fdef7f0d8d5373ac60b9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.8/arugula-0.63.8-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4cd43340703cf7933f9d890d8b6f125cd1f3184cfb55882f401a382b304048fd"
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
