# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.131"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.131/arugula-0.70.131-x86_64-apple-darwin.tar.gz"
      sha256 "c074c412418568fc2974a691e14325cf369409d1782a92c0132ccc957c0ef0b7"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.131/arugula-0.70.131-aarch64-apple-darwin.tar.gz"
      sha256 "3e123ea633693da8f1b367a79346e1e85e7413d219bb2229834d706f25aaac58"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.131/arugula-0.70.131-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4adac1f7db3c2f091d5087ae5063d3c099f6b54a3d725c14e6d2b8efb6c9da4b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.131/arugula-0.70.131-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7eff71cac5b83ccc401560c97bf4bc3310098b422472d26780111fd6b7f32c3f"
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
