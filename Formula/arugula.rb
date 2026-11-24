# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.98"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.98/arugula-0.70.98-x86_64-apple-darwin.tar.gz"
      sha256 "5f7e8c812fb8d6cc29b81fb869f8034c79df1096c17a34921a6fa75d8438ee31"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.98/arugula-0.70.98-aarch64-apple-darwin.tar.gz"
      sha256 "a479816d5d02c79160fbc0c39a624a04c7d0e0fd7dbba0df8a0ac92d3f7b2939"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.98/arugula-0.70.98-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0ccc41dd8a7d6aac9435cfddb575615b7ccfe7b4cc95ac4f9e46bfe92f2502ab"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.98/arugula-0.70.98-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6fffbf5399fdbb343272c888219266f2bd40a491aaf39ba27e72b1e3d4b425e7"
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
