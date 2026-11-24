# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.99"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.99/arugula-0.70.99-x86_64-apple-darwin.tar.gz"
      sha256 "f4c0f93bb8ba104a03484d5d70374e1b7bd4484661cc4f6ec546667b4370f642"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.99/arugula-0.70.99-aarch64-apple-darwin.tar.gz"
      sha256 "e779a388477e3cb775aa5d057eb32a706c356c7adab218b21f5d7af37c3c4889"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.99/arugula-0.70.99-x86_64-unknown-linux-musl.tar.gz"
      sha256 "aff4e267a30b154f858135b8ab0165e7f8e0432d9fed9ab681e4195227016ffa"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.99/arugula-0.70.99-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3a761e94641c37516593d0e769e4bccdb1b453058c0527f7f11946d177fbf8b7"
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
