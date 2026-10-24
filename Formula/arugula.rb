# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.13"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.13/arugula-0.60.13-x86_64-apple-darwin.tar.gz"
      sha256 "9ba71d548e86e079fae15170342c5e37debef93f7994dd74333461f47a1a7d32"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.13/arugula-0.60.13-aarch64-apple-darwin.tar.gz"
      sha256 "3c164ebde25804b44f610c2ac52ac9229a1db02f8ffa6aeafae256e1d53699b1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.13/arugula-0.60.13-x86_64-unknown-linux-musl.tar.gz"
      sha256 "431edc52e22cc8b86dce8e6cbdca1195b0fc583000282ffef4cc9e14cfe76c46"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.13/arugula-0.60.13-aarch64-unknown-linux-musl.tar.gz"
      sha256 "86e2fdb5b17ffb91078dc593735605f62f7c2aa04377c61509ed65c68f4c59ed"
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
