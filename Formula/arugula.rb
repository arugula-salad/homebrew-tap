# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.134"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.134/arugula-0.70.134-x86_64-apple-darwin.tar.gz"
      sha256 "6f28e0aced3a7acd86464e18fc691f5c391083c0cd4042d4d3b1bcc4d93da120"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.134/arugula-0.70.134-aarch64-apple-darwin.tar.gz"
      sha256 "3b4e06cc47caaa86775a3d4dd1c223a7068edc9d7a7a6ff018b85dee9361a3ce"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.134/arugula-0.70.134-x86_64-unknown-linux-musl.tar.gz"
      sha256 "80d0d84cb953d74f62afdd40900df8ee7f6523d65a2eb1a6461732c211260c97"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.134/arugula-0.70.134-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0085d9e619da3c88697b769a49d4f47dc7a23835e59efd83f47f9c3b9549fecc"
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
