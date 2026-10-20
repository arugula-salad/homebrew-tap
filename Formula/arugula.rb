# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.53.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.53.2/arugula-0.53.2-x86_64-apple-darwin.tar.gz"
      sha256 "df2128b56427596ca15e34f05b8300992b43402675c0390fe061ff0b57663b2e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.53.2/arugula-0.53.2-aarch64-apple-darwin.tar.gz"
      sha256 "ed841a0b506a3db89825db40bd43885f19ef666d1f50bb8595aec8c9cb8633c2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.53.2/arugula-0.53.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bca7dcb3b7f1e6bafdacf70c02d738274dc26e04c68717266fee955a0cb0ff4e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.53.2/arugula-0.53.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c3a67964db89fa35ad15b817c171bcac15d724194bb3c75558742600d3acdcca"
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
