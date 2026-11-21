# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.76"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.76/arugula-0.70.76-x86_64-apple-darwin.tar.gz"
      sha256 "44560de6b089974595dd4a5244dedda46a5460ce4811b6f0c451a7b6b18c9f0a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.76/arugula-0.70.76-aarch64-apple-darwin.tar.gz"
      sha256 "1bee87e103e759cca4f63d6e30df723b7c39edd4deedbfdfedad2e1d77e7403c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.76/arugula-0.70.76-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0624b0506def498bafde491d65ee87beaaf545d80630b506503128c3ea57ad5e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.76/arugula-0.70.76-aarch64-unknown-linux-musl.tar.gz"
      sha256 "65691e65dbc5abf2e9ef581c47f43acf3fcab7c752b791a0b4c760c3424a635b"
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
