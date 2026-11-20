# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.60"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.60/arugula-0.70.60-x86_64-apple-darwin.tar.gz"
      sha256 "e40c5711ab3144f5d051b0ac522e2188d5966540b064ff6e9ed9385d5a8a5b99"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.60/arugula-0.70.60-aarch64-apple-darwin.tar.gz"
      sha256 "bd0216edfc5162e634e63ae312ff49765feb68486e61bc3215f6b4a2fb65cd63"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.60/arugula-0.70.60-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9046ec024f937fd4289568c5939d0b7da159982c27a965f9b2ba1667aff6f6a0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.60/arugula-0.70.60-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2ef3eabe1f58fed92d6325342c381e466e9a53c984b35ce76f040c0f29abdf12"
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
