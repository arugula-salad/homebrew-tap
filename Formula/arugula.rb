# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.50"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.50/arugula-0.70.50-x86_64-apple-darwin.tar.gz"
      sha256 "4eb8111db1c9ac2b378b7f6f64c7c115a16038819ad429682230646b5b0262df"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.50/arugula-0.70.50-aarch64-apple-darwin.tar.gz"
      sha256 "d8ace92c24429380ebc2f3d0d3dc56022471bd84ddc716145bfcc492d5a24517"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.50/arugula-0.70.50-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8f05b8c18dbda1d3d27b5071aa615219d0dd1bd0f1fbbde9d028c8a453ef14fa"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.50/arugula-0.70.50-aarch64-unknown-linux-musl.tar.gz"
      sha256 "676df20f33c7501c6405e470ca0e4af68a8c5f0be1f2a3fac82b02b68edca1a0"
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
