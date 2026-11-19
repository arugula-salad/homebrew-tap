# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.45"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.45/arugula-0.70.45-x86_64-apple-darwin.tar.gz"
      sha256 "06d0424c0dc429055940acfaabf307bd0cec36d2bd9615316b82ed484cb0a9b6"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.45/arugula-0.70.45-aarch64-apple-darwin.tar.gz"
      sha256 "8fd6baf8ff264e200bed5af0404f40f862a717c13a8463f58a6ddccfd0f747b2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.45/arugula-0.70.45-x86_64-unknown-linux-musl.tar.gz"
      sha256 "25a1e348806192fc6d1aa24b995b0fe63768d14fcda49ac8a6c24413b6364d29"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.45/arugula-0.70.45-aarch64-unknown-linux-musl.tar.gz"
      sha256 "103f2662ee5af875921139b36f77cf509f6d35d88e900337474d7176a5a355b1"
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
