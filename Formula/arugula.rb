# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.52"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.52/arugula-0.70.52-x86_64-apple-darwin.tar.gz"
      sha256 "44d362108d78d15612f8afa3230747e26868aaf1aa8a1ba2ea02d0eb0e45ae41"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.52/arugula-0.70.52-aarch64-apple-darwin.tar.gz"
      sha256 "4cc0966dbd56f2eef08ffd954061a1e44a774cca4350417536fe7531dd23ef48"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.52/arugula-0.70.52-x86_64-unknown-linux-musl.tar.gz"
      sha256 "694aa04148db74afed45f641de9c01ead53bfa9164061dc3f856a9c61c58dee0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.52/arugula-0.70.52-aarch64-unknown-linux-musl.tar.gz"
      sha256 "df4856fdc7457b359df6c515a428a5eba7dcf5916f7f4dd85f7f7f5e1c3fe155"
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
