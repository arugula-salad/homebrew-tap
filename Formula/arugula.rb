# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.18"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.18/arugula-0.60.18-x86_64-apple-darwin.tar.gz"
      sha256 "534f31d23e8cdb9129dabe9889333b9cd53143e561225011b5cb0076e05f6b8c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.18/arugula-0.60.18-aarch64-apple-darwin.tar.gz"
      sha256 "c7797fba947e7a4bd5850305906990a9366287bdfaa52096316856cacf98d07b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.18/arugula-0.60.18-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f501bd1af107a191610bdc43ee21de99ad1625ac4688e4e08021ca9750ad12e1"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.18/arugula-0.60.18-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f4afde47786a00ab91b5b92a2999ed292fb7b8826fe5f6d81137c14aab20a731"
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
