# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.56.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.56.1/arugula-0.56.1-x86_64-apple-darwin.tar.gz"
      sha256 "0eb5f3962be319075073e8c3c49a6233a634eddf9d8279f535dc11157e25e0a0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.56.1/arugula-0.56.1-aarch64-apple-darwin.tar.gz"
      sha256 "f31418522754b061c4be5bfe8f14019529dd2658b2e35f861faae413ff7afbb8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.56.1/arugula-0.56.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c417dea0f11dc6d0953a2a5f50fc1f65ce63b70de05be787295e31b31c8425a0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.56.1/arugula-0.56.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7f7050712702db3761409e51f2ebf241c0e6b550740ced24d87655507e8668b0"
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
