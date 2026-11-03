# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.14"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.14/arugula-0.66.14-x86_64-apple-darwin.tar.gz"
      sha256 "59a3dfc0763552c4a8bb47b6c04baae5a9a00c0b675419d9e4cd4025330ee6f8"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.14/arugula-0.66.14-aarch64-apple-darwin.tar.gz"
      sha256 "43b21b996c3300fcfb7502aa239767fc06cfa2d03775e5a4ab54775f737d4189"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.14/arugula-0.66.14-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d5955f077d97165e74635eb58324a045ea6b88fe7fae5d156c1d74921ca7406f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.14/arugula-0.66.14-aarch64-unknown-linux-musl.tar.gz"
      sha256 "879e359d6d32d4362bff6bbc9312f69605b0a3ca17200e43d9c197dfce27ec1d"
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
