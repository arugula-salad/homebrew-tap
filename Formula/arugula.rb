# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.62.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.62.0/arugula-0.62.0-x86_64-apple-darwin.tar.gz"
      sha256 "e4a7d3299b3686b24ba95a894e037ecd7d852f1fc5f9edbd6ab44fee0d3d7036"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.62.0/arugula-0.62.0-aarch64-apple-darwin.tar.gz"
      sha256 "68d231512eb2d64411aeccaca44c82925d67a24d8ad3ce4f09c1326365c346a5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.62.0/arugula-0.62.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8481513ea961a42e1b4fbbb789057dae5acda3111fb56ac47a06535404284719"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.62.0/arugula-0.62.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "13922a45f70c356f996101888b373671ab6170642b46353913b60ea6f99b3061"
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
