# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.152"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.152/arugula-0.70.152-x86_64-apple-darwin.tar.gz"
      sha256 "2800c87a1835f4ddbd6fa6a638340a363ee45db3e6e2a1c3aeb9372b860d223a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.152/arugula-0.70.152-aarch64-apple-darwin.tar.gz"
      sha256 "93266658055992c3e0ac6922ff1cf3cdba9c5b19650f65171cab3d010c4a8159"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.152/arugula-0.70.152-x86_64-unknown-linux-musl.tar.gz"
      sha256 "952ac2ecc1f52b70c9db1fab57811a7800e823e4215ef76fc74b09ea293ab659"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.152/arugula-0.70.152-aarch64-unknown-linux-musl.tar.gz"
      sha256 "390629a8e7273ae8c42d3fbb52c65cc73e611229842820c68a9fa38872cf7171"
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
