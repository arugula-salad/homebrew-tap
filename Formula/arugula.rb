# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.36.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.36.0/arugula-0.36.0-x86_64-apple-darwin.tar.gz"
      sha256 "a436006c87745f5dff2ada939fe5b1e0d3bcdbacd5fe143abd429fe762ab21bc"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.36.0/arugula-0.36.0-aarch64-apple-darwin.tar.gz"
      sha256 "b5a47a88d5ed9a3a446993a84b88589720a4befc4d7538bce11931a67b94d121"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.36.0/arugula-0.36.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c4c12d2e318246977f6884e1e71124110f2ad0a3258abc75c53edcac2fa68b7f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.36.0/arugula-0.36.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f4baec443fa9bb6bcf8cd7fe4e3379b367a443d69fb3c697a8cd908fc1a81417"
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
