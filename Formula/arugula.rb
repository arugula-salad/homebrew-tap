# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.25"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.25/arugula-0.70.25-x86_64-apple-darwin.tar.gz"
      sha256 "08764c65541c807c52760901c5eed61380ac6f9fe94aac0aadda2ff423f89447"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.25/arugula-0.70.25-aarch64-apple-darwin.tar.gz"
      sha256 "86905030fdedf83f2ee974e360e6a551fc419febad3cf569f5fb2d02862c9c60"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.25/arugula-0.70.25-x86_64-unknown-linux-musl.tar.gz"
      sha256 "15fc8a5a9372f8af9ad62422ae4a74fdd813ba562e992a9fcd48c59a5186aa62"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.25/arugula-0.70.25-aarch64-unknown-linux-musl.tar.gz"
      sha256 "526fd05647d73a2664ace577509ef2c47fe44deddecd6101036985fc46e11722"
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
