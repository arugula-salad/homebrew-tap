# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.38.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.38.1/arugula-0.38.1-x86_64-apple-darwin.tar.gz"
      sha256 "95b18f454c79eeafeedcdb7bc3aa03f78b92e8dc8ebd6d4055f06562259544a0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.38.1/arugula-0.38.1-aarch64-apple-darwin.tar.gz"
      sha256 "cf4205720343e09802acc99101377f4291ffcf07b2e156cfe924c589f1805b65"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.38.1/arugula-0.38.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "78ba40d94e1eca55cd3bc25725a973376fd7700be10d442ceb10136399d91f0b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.38.1/arugula-0.38.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f186834e66854c965853edaaa454730f8571d9cf4b494a3f3ea2f16b6180eb82"
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
