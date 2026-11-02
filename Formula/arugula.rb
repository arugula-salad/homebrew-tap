# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.9"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.9/arugula-0.66.9-x86_64-apple-darwin.tar.gz"
      sha256 "987468319e7a4d72ac240aff04b7e835ceaaad6b03569130018e2f84b13975cb"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.9/arugula-0.66.9-aarch64-apple-darwin.tar.gz"
      sha256 "c3acc02de65aab000e521a6799c39630e62539b3247c8f16632b5ae306bfed1a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.9/arugula-0.66.9-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c353837e72f2b87fbe3eb5cc404623bc7a77b589bb80908c5cdad84f2fa5baed"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.9/arugula-0.66.9-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5bca2a7a540d3e5f1d92aab8c4a011636a4ea9b80ae247d81fa844af6556a54b"
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
