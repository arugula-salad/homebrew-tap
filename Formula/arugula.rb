# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.31"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.31/arugula-0.70.31-x86_64-apple-darwin.tar.gz"
      sha256 "7370e66982aaac8e6a7767438bd29055b47f068f72171985387894b07a347104"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.31/arugula-0.70.31-aarch64-apple-darwin.tar.gz"
      sha256 "cf873a938a86cafc2949851b855427b5bb6d9cc486f052492614e17616473664"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.31/arugula-0.70.31-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1036a66456b774ec18d73aa4df7be57ec90fb1a17cf9f55973d5a22be4e4182f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.31/arugula-0.70.31-aarch64-unknown-linux-musl.tar.gz"
      sha256 "de05397db50d9bcecf5ed3822084501ddc8aaba360b6763ca3713eda33b78f86"
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
