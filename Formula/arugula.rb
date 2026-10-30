# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.65.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.5/arugula-0.65.5-x86_64-apple-darwin.tar.gz"
      sha256 "2c1a9f34052f56016e54c912a1157d84f7a1297fd91417119655a422ae1427da"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.5/arugula-0.65.5-aarch64-apple-darwin.tar.gz"
      sha256 "9a303b377ed934b28648e39fa6d9bd5eb85fb18868b75e2ec28add365d55a21f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.5/arugula-0.65.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c7b0662dfc11206a8b21c78a78534566031232f372dd2ad20fec96c5ad2699a3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.5/arugula-0.65.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f73aa5b90d13183f067dac7e2f5dd47e62da680027c8b2fef78056b960635bd8"
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
