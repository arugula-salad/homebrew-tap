# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.40.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.40.1/arugula-0.40.1-x86_64-apple-darwin.tar.gz"
      sha256 "3c502a6c979b3d8933efaf8da8673371a2b7df70203de6b4616e1e863e326302"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.40.1/arugula-0.40.1-aarch64-apple-darwin.tar.gz"
      sha256 "2c0b8394d63ff207bcb28c04a53d53ca9531272f53fd7810936ea0f952e1e999"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.40.1/arugula-0.40.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f640a5d1dce8b3721e86a6363d07c051bac2898630e54aac3859e6c0c407ac59"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.40.1/arugula-0.40.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d2608dc1073ba988234cbb772100d04cfe2646d4121d173546b453967152f743"
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
