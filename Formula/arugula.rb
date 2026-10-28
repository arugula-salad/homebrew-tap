# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.65.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.0/arugula-0.65.0-x86_64-apple-darwin.tar.gz"
      sha256 "b287e61491665e4fe058e916ded3e56abb893cce875b6a86ee958eaffc0e8a48"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.0/arugula-0.65.0-aarch64-apple-darwin.tar.gz"
      sha256 "8364866f4272ebe6ead2322cef69ea4da38851e6ac9894f35de5e2e577660bb3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.0/arugula-0.65.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f325467ae520eaf3e085a1f48f1cd4c23be56958ba023662d95f24f35d42dcf1"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.0/arugula-0.65.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4e5c648955bf79d6be10036ccb2672055e6da6de56400a4d573b8775aa82fd4e"
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
