# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.55.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.55.0/arugula-0.55.0-x86_64-apple-darwin.tar.gz"
      sha256 "0cefc67ac6133725f368db09e61713c7814e2ff8b07233e6fa5ba4137070aff5"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.55.0/arugula-0.55.0-aarch64-apple-darwin.tar.gz"
      sha256 "71b3888775cbfbf6d71267c5b5ee1847aaf3293ff83e453b31ca2f67618206ef"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.55.0/arugula-0.55.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "66afe0974a89e96724e5f67fa4531c3a762c4fdd4469d70e2b0749d7ceb9f043"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.55.0/arugula-0.55.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b707eb8b13690d5abf37f541a41a22bf5e898037040522c4bd53526d2bdee771"
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
