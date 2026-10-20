# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.52.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.52.0/arugula-0.52.0-x86_64-apple-darwin.tar.gz"
      sha256 "2c29a456b1a69353a31c3ecc2bf88170f5b66da0c537048420ec628fe52a9cdc"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.52.0/arugula-0.52.0-aarch64-apple-darwin.tar.gz"
      sha256 "8bf5a4a6b799d57679edfdb30883a35497e2fe9c33f2e5391775a9487d6b7b75"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.52.0/arugula-0.52.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b56e339c1c4b10001d421f66ed6ea3f4126db49f1d42afb2a522bab8597fe8e3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.52.0/arugula-0.52.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8722d00854870d2aef85640246d6721a56ec80e59f7e7de5f54559e6fa93a328"
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
