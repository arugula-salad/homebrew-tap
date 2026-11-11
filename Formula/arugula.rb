# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.13"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.13/arugula-0.69.13-x86_64-apple-darwin.tar.gz"
      sha256 "9b66a60d76510c7308aabd10a3e596b28c4eb2266679d35a674bf4e42b3f4274"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.13/arugula-0.69.13-aarch64-apple-darwin.tar.gz"
      sha256 "22844a3f6f67db4dda2a9a74cf6b624f5c9faea04e86f7468a52299586bd3fbc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.13/arugula-0.69.13-x86_64-unknown-linux-musl.tar.gz"
      sha256 "798104ca88c1d4c4343a8bb75f86a92b1fa11e4550215115b0d10960d52441c4"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.13/arugula-0.69.13-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f02d06670372932c36fee9dc01044ebcd5a0b8574d38e4726f7c0da998ee75ac"
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
