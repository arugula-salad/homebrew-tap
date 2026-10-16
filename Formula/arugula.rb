# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.40.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.40.2/arugula-0.40.2-x86_64-apple-darwin.tar.gz"
      sha256 "b2d4c84860c1a0e2151c1b9a54a62911a3a4c44514f3f1bb18e6a36f512e53c3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.40.2/arugula-0.40.2-aarch64-apple-darwin.tar.gz"
      sha256 "c27f0b09c7bec5de7ffba29ff26a656733a4187d670fb19268cbc2ecda4aeb5b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.40.2/arugula-0.40.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "25961c07d974fcaa35ed09de2bdc26e90cd3ff935ce51bd402d6a91e33079bfd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.40.2/arugula-0.40.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bd1029c8d53b4b1337f2ea3a1b8c8215be498696930877f535acf3ecf3cf2cf9"
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
