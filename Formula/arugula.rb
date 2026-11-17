# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.37"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.37/arugula-0.70.37-x86_64-apple-darwin.tar.gz"
      sha256 "b755b6138900f6ad898895ddfa02bff7e7bb4585cda48f45aac9bec73e0aca59"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.37/arugula-0.70.37-aarch64-apple-darwin.tar.gz"
      sha256 "b67633fd05f26acfb9122c7b57c5e23d3041d12c27f854be4a7d290911e959b5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.37/arugula-0.70.37-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ca2e44c681aa8dd8b75fbbfa513f7adfe8ee19ba46bec49395449ed975991daa"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.37/arugula-0.70.37-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5c37730c130242a627c037ae2967e47a4c2d68c8bec24ec5ef7283b96a81daa2"
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
