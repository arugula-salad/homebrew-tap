# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.151"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.151/arugula-0.70.151-x86_64-apple-darwin.tar.gz"
      sha256 "d00b1ae4d2bc17b3b18c8b8ba64f52817a2fcd2a7bb43fa0c266e93f007678c1"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.151/arugula-0.70.151-aarch64-apple-darwin.tar.gz"
      sha256 "94e638f57e38a013d526707b88afe836d271cae4744f5c81c0e116044863fa46"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.151/arugula-0.70.151-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f8e97a611e1dd5f50bf043b972f5b0816de7a37c17ee7175a4b56ba126ba3190"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.151/arugula-0.70.151-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b7881b77d7031450f6398d5fe5e040a104331c4a1fc1b5a9cc863ab03609f46d"
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
