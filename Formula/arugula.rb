# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.123"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.123/arugula-0.70.123-x86_64-apple-darwin.tar.gz"
      sha256 "6cc0c517d76d0fc93e9ccfc046bc0e1f5935d233442a639a225fd216be79f8bf"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.123/arugula-0.70.123-aarch64-apple-darwin.tar.gz"
      sha256 "a46d269d651c3d243bd8a0fb1a7a94072e9887cb7f9988824bac7fb573bcf01c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.123/arugula-0.70.123-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7de90dbfc4af312d095a2c5cf88aae9008738adfa6be56a7d20c04a04c8d530b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.123/arugula-0.70.123-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5472a1b1b25e05648741c889a5083a3fd69604adbc223c6065d025b18dda248f"
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
