# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.19"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.19/arugula-0.60.19-x86_64-apple-darwin.tar.gz"
      sha256 "42e1d2e7ac278cdd80f85f2b06d263a689a6cefb31a4ade378bd7153f377312e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.19/arugula-0.60.19-aarch64-apple-darwin.tar.gz"
      sha256 "a9dd5edde3d50bb1765520194c6c516e4434441d9dbb02735480cc9ae5e5aec5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.19/arugula-0.60.19-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cae91c9e06701fdfa1876966fe3f59e3e7d016fe2bb5f87a118de737e78820a0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.19/arugula-0.60.19-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d5980cb9cd7e407f8ac0a40be1303dcd6537fefa75988d46da15aa8e9c746707"
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
