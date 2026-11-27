# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.150"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.150/arugula-0.70.150-x86_64-apple-darwin.tar.gz"
      sha256 "6c366e06e62e36bc634f3c5121513ca61b98fcaecd0cf3057f7c20c45154b76e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.150/arugula-0.70.150-aarch64-apple-darwin.tar.gz"
      sha256 "8217c03457b6b77b596ec3cbac9bfe0c99ad3e6c118966fdc6ad9f426e36bec4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.150/arugula-0.70.150-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0bb97d2cd420ab5a74ae1d09bf0230ed01a96dcee65037c2313fc86275a3ef93"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.150/arugula-0.70.150-aarch64-unknown-linux-musl.tar.gz"
      sha256 "65b3798f9321e8ccd883f71ea12be37fae694cbad87f7aed56aba4a71a70448d"
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
