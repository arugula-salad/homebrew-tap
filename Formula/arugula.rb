# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.16"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.16/arugula-0.60.16-x86_64-apple-darwin.tar.gz"
      sha256 "1c404528412abb003843f1f54eb8bed528647fed1c843244de1231fa21e5735b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.16/arugula-0.60.16-aarch64-apple-darwin.tar.gz"
      sha256 "e51140939d940983e3a6566b0b1540112ada561e89d832c092e4183f69c6cc39"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.16/arugula-0.60.16-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f723e2dbf973d0a8b7c6c6d21562c3c46da7e4e67393b7816ba896abbeca9758"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.16/arugula-0.60.16-aarch64-unknown-linux-musl.tar.gz"
      sha256 "aa8e89344192e8e59ed4f9eb7e74cbcbdfa529ce73b5a5e918ed96a9ba80a640"
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
