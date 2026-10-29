# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.65.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.2/arugula-0.65.2-x86_64-apple-darwin.tar.gz"
      sha256 "5569eb3d776f93e8144bd93512cf08cd724fc4e5ceb5edff7d832381723bec24"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.2/arugula-0.65.2-aarch64-apple-darwin.tar.gz"
      sha256 "8966336fe318067e64eca368a866f07f81dc363b2419808396e16f840338ea6c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.2/arugula-0.65.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "35c563f270fdc6c1f63389a09f36f9926af7eec25b5ad2528743895ecc1e4fe8"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.2/arugula-0.65.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c681cb5dea348451e20bef84e3a0a13e9070b9ab30292db98c80a50c6f8ce496"
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
