# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.159"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.159/arugula-0.70.159-x86_64-apple-darwin.tar.gz"
      sha256 "d8d460588310ef038e581cc2ac35831ce78c8a78ffd7102e276b18921ee0d686"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.159/arugula-0.70.159-aarch64-apple-darwin.tar.gz"
      sha256 "83e6c5a1d0a314b9bc8479a0fb56d6c54f419f3effb5e0a10a7d8a9c8ec131f2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.159/arugula-0.70.159-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9fb517bc0152748eaad6d41f3407012feaaa5cfe0a6b5b9b462f9c37062c783c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.159/arugula-0.70.159-aarch64-unknown-linux-musl.tar.gz"
      sha256 "77f1e0c759e3c7f8fe192bf94f3ec9f31aa5f3b26b3e336535461a596468c9ab"
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
