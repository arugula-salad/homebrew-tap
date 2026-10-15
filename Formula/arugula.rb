# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.40.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.40.0/arugula-0.40.0-x86_64-apple-darwin.tar.gz"
      sha256 "878d389297150df89fc7ccab5b0c7a01ff9059ea06cdb01581944c49c28b6717"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.40.0/arugula-0.40.0-aarch64-apple-darwin.tar.gz"
      sha256 "5e243c3f68d8778eafc757fb2199419d737045c496859fa24b20982cfe265b44"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.40.0/arugula-0.40.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ba7cc9784b0b486c4ea97c5e0946a56914e769e513ad35de22a6260b798235bf"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.40.0/arugula-0.40.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5ed45a22ed49fa4670db59876e6f2f32a70e16aade96602c19741ba6a2afb81a"
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
