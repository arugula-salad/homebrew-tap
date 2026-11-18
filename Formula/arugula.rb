# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.43"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.43/arugula-0.70.43-x86_64-apple-darwin.tar.gz"
      sha256 "746f2c857f56b5d4ea72c94b1974080164b02a6b920cc64448f5bddde6ba3406"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.43/arugula-0.70.43-aarch64-apple-darwin.tar.gz"
      sha256 "a277ab8a0d746c1d0ad25d8d6951e9f83cef76434bce4aad8a98774fab9cc393"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.43/arugula-0.70.43-x86_64-unknown-linux-musl.tar.gz"
      sha256 "209afdae3cac131b69a5f8f4ffaf539b925a320d06070b3b9b610cb4abe62c8b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.43/arugula-0.70.43-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cdb7d24b738c0425e85c04aa30dc80183e8f848d63bc4f85be0b3da810fdf449"
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
