# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.64"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.64/arugula-0.70.64-x86_64-apple-darwin.tar.gz"
      sha256 "c177ded6964d67ca9c836afa63969381284c00e1fa86bc93efb0b70d8dd8cc22"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.64/arugula-0.70.64-aarch64-apple-darwin.tar.gz"
      sha256 "8ddee5c505644d2e39275ac1718f89359382a2bae4c489388a162224ee2b3fb8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.64/arugula-0.70.64-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2bcc858ba6512cee9be83b989965c231db367ca3a0cafb29432f66c2c96598be"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.64/arugula-0.70.64-aarch64-unknown-linux-musl.tar.gz"
      sha256 "43d2ebb8bdeb19efb6cd31b86330a5aca64a33416aece665a4ab12357a03d131"
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
