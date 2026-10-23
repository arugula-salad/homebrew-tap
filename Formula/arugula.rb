# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.4/arugula-0.60.4-x86_64-apple-darwin.tar.gz"
      sha256 "0bcf73e3b7a700fae5c2075cd803c89a55200d5d688783b085f4d53adc0b960f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.4/arugula-0.60.4-aarch64-apple-darwin.tar.gz"
      sha256 "2e4f8786f031981ca494d5c1492b61853298b48677f3b828d13ad40a4dedf61d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.4/arugula-0.60.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c1560dc2505fdfbb275c9dcca1fb4867f5edaa5f7a8d4b72fc242df8b008b556"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.4/arugula-0.60.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dcb7047d974a3ef6e5ab3aa6683325f592cbddad07c2cd3c3963be5f33e61429"
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
