# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.17"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.17/arugula-0.70.17-x86_64-apple-darwin.tar.gz"
      sha256 "427c76cd4768ce5cd9be06bc6ea530461531c7356fa16826217617f6056b6fa9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.17/arugula-0.70.17-aarch64-apple-darwin.tar.gz"
      sha256 "150bbdb8c6235a75a45e5f97a3d89ffe024a4f3a1fd9e109712b69ca5804452c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.17/arugula-0.70.17-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fe50b99ce64fb87fe9b4f46c4c63a64f67b7fcea40dc1dec67549d6a19ec8280"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.17/arugula-0.70.17-aarch64-unknown-linux-musl.tar.gz"
      sha256 "01027fb964e7a6e72c21bc37fc63eca6ebc2b0348eb20df5673b31d419d993fd"
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
