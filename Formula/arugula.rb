# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.96"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.96/arugula-0.70.96-x86_64-apple-darwin.tar.gz"
      sha256 "14628c454714306f40006648df362b25032b86e0daf5ef5e206c8ea817274659"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.96/arugula-0.70.96-aarch64-apple-darwin.tar.gz"
      sha256 "5ef60d9618c9cf7639e85f72bb1406b8225e3d42c76d28ff523a94c3d21324c8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.96/arugula-0.70.96-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b32c5eb495bdb951db04f3070e4d423605f545135fff673b1f117272450a85af"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.96/arugula-0.70.96-aarch64-unknown-linux-musl.tar.gz"
      sha256 "677159e862c8cdd3acde96c36957274e8074a7332ea517aeb81d01f7573e2415"
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
