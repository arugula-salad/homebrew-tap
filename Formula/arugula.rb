# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.33.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.33.0/arugula-0.33.0-x86_64-apple-darwin.tar.gz"
      sha256 "4df0e420b6dd6492451d95bf86f893a64255cd523e9bfced21dfded4e51e440a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.33.0/arugula-0.33.0-aarch64-apple-darwin.tar.gz"
      sha256 "ee4e611f0bc7c86dd148974992552bd76606100208366ab83729b5fad2be8c15"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.33.0/arugula-0.33.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ffc544393c9fa4b760f84a3b60498b5d2294234721e83e15372b6d422d851a7e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.33.0/arugula-0.33.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2aeb3a0bafd4e18ea79634c51e44b0e325ba838e476723baef13db8ee4e802fd"
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
