# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.10"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.10/arugula-0.66.10-x86_64-apple-darwin.tar.gz"
      sha256 "4dcb3082eaa46c14a9e555e7bfa5f673006b219dc3477e21b0057cbd49598c00"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.10/arugula-0.66.10-aarch64-apple-darwin.tar.gz"
      sha256 "948ac653cc6d5e016707c00f1120017fdaf5d259b91e2ed21cb72181cc2d692b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.10/arugula-0.66.10-x86_64-unknown-linux-musl.tar.gz"
      sha256 "125e3f8a681e66a0318a63328f2ea726ec3725aa1b2e7ebaa0a7763abd4f92ea"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.10/arugula-0.66.10-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3e1daddde03fc53ef55f9c9eba2ac24fee5dc3c8bd28bf316216e308c32617b1"
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
