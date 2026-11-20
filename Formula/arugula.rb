# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.61"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.61/arugula-0.70.61-x86_64-apple-darwin.tar.gz"
      sha256 "2f4e3c3e50fa9835ea56126a304cd292b3a6b3a41ad102469dcbfd795157cbcc"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.61/arugula-0.70.61-aarch64-apple-darwin.tar.gz"
      sha256 "14c23d9bc5eedcc251aa0c67053c7698a0da6de751eb6b1e0c147a587c8df89d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.61/arugula-0.70.61-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c3e66302f90407614f34e286d606e0fa66644bdebc6ad72af8271dfb5a6d6cba"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.61/arugula-0.70.61-aarch64-unknown-linux-musl.tar.gz"
      sha256 "37ff98149486c6672477be3109b58c760cd455c09eb72378373cab2045dd933e"
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
