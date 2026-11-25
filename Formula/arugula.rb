# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.110"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.110/arugula-0.70.110-x86_64-apple-darwin.tar.gz"
      sha256 "5844e8ea47bfcecf8b6cba8c46f5f076f0690922eec13bb540b2d707dea5f5ca"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.110/arugula-0.70.110-aarch64-apple-darwin.tar.gz"
      sha256 "0172b10dc26c463dcd2e3700270dbe4e59c480baaaffea61ff0501e6ce78beeb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.110/arugula-0.70.110-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1dde458d8e193106a91404afa816626b98f5cc820e6b8e6969ded2ab45280c00"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.110/arugula-0.70.110-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0ee8f9641980e5cdaafa0bc3a45ad1436fc5417cac68797e06287ca4f10bbe93"
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
