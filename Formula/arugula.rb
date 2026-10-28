# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.64.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.64.1/arugula-0.64.1-x86_64-apple-darwin.tar.gz"
      sha256 "a489aff21f4421454dadc6f5e148982863a2a6b5b99b839d533f5311de2f290a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.64.1/arugula-0.64.1-aarch64-apple-darwin.tar.gz"
      sha256 "b2ee093e62174252bddc3db34a09da78af4119a966d18ace04aed3b32d211307"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.64.1/arugula-0.64.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "38d1c00e67526e41993d21db3193e07161061f5066c6ca1efd777e635f7d8d19"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.64.1/arugula-0.64.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "32dcfc3985ae592cfa6858fd86d9cb44169ef091388c19f8315e4fbe3a715c98"
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
