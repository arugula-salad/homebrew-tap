# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.1/arugula-0.70.1-x86_64-apple-darwin.tar.gz"
      sha256 "61ee62c28ec346a1c6061e00d889d2841e543256121c11fca4f796f3dd6f9f67"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.1/arugula-0.70.1-aarch64-apple-darwin.tar.gz"
      sha256 "06610e8b98298ae648e3ddfb0e835c957888fd606406c62c48cb473f599d2d2b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.1/arugula-0.70.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "91fff29a07bd3948c6535e3016cd7265b3e89fd282ed80e50f4de4d44237bbb4"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.1/arugula-0.70.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a69843fbe7b79a3bf1c4399c5edd6a5acfa31ead985fbf0d29419d0daa8f4869"
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
