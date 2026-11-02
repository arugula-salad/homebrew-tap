# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.11"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.11/arugula-0.66.11-x86_64-apple-darwin.tar.gz"
      sha256 "6eeaec97b82a21dc9ffc0f3b9dd99d9898530a5303fce1622542d4086528e294"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.11/arugula-0.66.11-aarch64-apple-darwin.tar.gz"
      sha256 "2cfde9fbd1b2584261930b098d965ced2973918e77c8e5105cb7cdfc8ab4bc4b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.11/arugula-0.66.11-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9b6ab0bac7ebc2987846e46b4cf81ca2035dcc19d8c220b85ac91db9f459aa9e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.11/arugula-0.66.11-aarch64-unknown-linux-musl.tar.gz"
      sha256 "de68372158dbf1b8a0fd81f3c6e4fe94b58d0efc60bbc32cc7067fcf831ba0bd"
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
