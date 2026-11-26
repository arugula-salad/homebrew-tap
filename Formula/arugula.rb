# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.121"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.121/arugula-0.70.121-x86_64-apple-darwin.tar.gz"
      sha256 "4b465a7fea87448067e6142c9774688e2e3373cb1ed973c4f1d968233a2f04fb"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.121/arugula-0.70.121-aarch64-apple-darwin.tar.gz"
      sha256 "fadb4b58ad4c7e33edfa41419ecebcd16d46e4ce66643473925053e3f1f290f7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.121/arugula-0.70.121-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9d47542e7612aa4667a258b992793262372285aee42cd4dce98d72627c93ee57"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.121/arugula-0.70.121-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6483cad1354729ea9280d9c760bb62a3deac4ea8f894a0392ca3bc30b5e550db"
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
