# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.33"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.33/arugula-0.70.33-x86_64-apple-darwin.tar.gz"
      sha256 "266e9044be02e3acb4f8f7059f4da267f3bd6ed8716077744480181507492bc3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.33/arugula-0.70.33-aarch64-apple-darwin.tar.gz"
      sha256 "d13bf1fc275de01b965387af8975627c80c2f204fc1f5bc1a13802eb28f5159b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.33/arugula-0.70.33-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9a07bdae94db4805c2fb4e7c11de000e6719a25387477120416ae16cd4d9ead3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.33/arugula-0.70.33-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a4d00836f8cd521c2a03fe36cb5a50f43a3f12bcfea25f377d31914f1527a036"
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
