# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.61.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.61.0/arugula-0.61.0-x86_64-apple-darwin.tar.gz"
      sha256 "64a7968cad771af40914cf3bc893062282630b8266aa808db3e19cf9cd6f4b66"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.61.0/arugula-0.61.0-aarch64-apple-darwin.tar.gz"
      sha256 "97caed8b739149d37f22fb975068fd0f221b392d8efdab6e964b55821de4e64d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.61.0/arugula-0.61.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6d183ec675eb9e72efe419f3bfd8d0660ad10dc406cd6da5dbfb213e46a4efe1"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.61.0/arugula-0.61.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6c8babad0bc13de64cc1d3a90d5d04b5a185839af16e3d4911531494cb58961b"
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
