# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.58.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.58.0/arugula-0.58.0-x86_64-apple-darwin.tar.gz"
      sha256 "0b1435685689ffebbb786f824f175575aaf340850017956f20adf964bade5e8a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.58.0/arugula-0.58.0-aarch64-apple-darwin.tar.gz"
      sha256 "7c6f5570419eb1151efe0038db85b0d331eb41858b318c7e8326effdd7e648ce"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.58.0/arugula-0.58.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b610181d8922d5f57cb9ff1f80bd940e9d74e2483024618d471ae85e6c219f59"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.58.0/arugula-0.58.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "494cbb16f1282341494648a711cf31a1ae5e52e98ba0979417637d5e5f4a5660"
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
