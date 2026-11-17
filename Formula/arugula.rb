# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.30"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.30/arugula-0.70.30-x86_64-apple-darwin.tar.gz"
      sha256 "e414a2246e4313993d4ad2e3178dd155232445e14bdd92f35b446a91cdb16902"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.30/arugula-0.70.30-aarch64-apple-darwin.tar.gz"
      sha256 "2299bed61e744c9ba66dc49c2f75cbb2c733011746fd2e40957ed7a1be411ff1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.30/arugula-0.70.30-x86_64-unknown-linux-musl.tar.gz"
      sha256 "14ed28a42935298dc631745ffdf325ca5b63cada716b470b66bc815eaa7402d2"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.30/arugula-0.70.30-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a5f5bc30df2d8152889b767502b48045bf8e1b89c92e9acec1134e31cc5e9c29"
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
