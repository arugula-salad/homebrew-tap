# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.4/arugula-0.66.4-x86_64-apple-darwin.tar.gz"
      sha256 "c0e8656fceb29fdc4369aae10cafe8c53502e9e179a4ea2fc87527c0c1ebeddd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.4/arugula-0.66.4-aarch64-apple-darwin.tar.gz"
      sha256 "272372459521807620500852a0d66fa560b41549778ada3a9028cacb162316de"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.4/arugula-0.66.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "50081c127d5818b6d49c616b3c2482b5cf62e21097ba0f4df74051df8110791a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.4/arugula-0.66.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "11c1e74cd40f9db117713c13d59a463217b663cd4cab3d0093f123a92484bfe0"
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
