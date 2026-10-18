# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.42.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.42.0/arugula-0.42.0-x86_64-apple-darwin.tar.gz"
      sha256 "010b94963e1739c6ec46f9a1c4765d6059d95e1a087df5e3b0ca29dba306c1c6"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.42.0/arugula-0.42.0-aarch64-apple-darwin.tar.gz"
      sha256 "adbfa56d4367c9309dd4ea0eec4d0ebc90de6ae86425e7b4e9f77d87a05f1a26"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.42.0/arugula-0.42.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8f93023ec9c23e9136c2d8d6bb0752aa6aa8cba6a4a7f72ccebc663b5462e6b8"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.42.0/arugula-0.42.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4574906cd0b7ebd48a48c91837a0a787936602edee3136f5d7850077bf3de472"
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
