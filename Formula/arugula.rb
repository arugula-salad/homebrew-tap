# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.17"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.17/arugula-0.60.17-x86_64-apple-darwin.tar.gz"
      sha256 "7cd377c05f0d486353d507be69a35332a0b65645fd8e2cb054d7f0b0f9121b15"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.17/arugula-0.60.17-aarch64-apple-darwin.tar.gz"
      sha256 "312a6a1186a9a86a9e9f8b771a19a3a4b988c8de4a34c55bff1649ac9781c234"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.17/arugula-0.60.17-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6a2436053967f45a0dbfc131edd16c9de8306d442aa210d08bdff0806c6e7fee"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.17/arugula-0.60.17-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3271e839ec772983d0732ef23ab7cb38a8487766195958d6e5d334ca0648533b"
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
