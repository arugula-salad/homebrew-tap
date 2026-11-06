# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.68.6"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.6/arugula-0.68.6-x86_64-apple-darwin.tar.gz"
      sha256 "0aee11ae1a362844361026dc7a99a76cf72e236feb0af6233b00f8e643ef3bf2"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.6/arugula-0.68.6-aarch64-apple-darwin.tar.gz"
      sha256 "19dd82369a621651cbd1f765b68ef5ca55aeeb93319f015cafe342f4980a6b6a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.6/arugula-0.68.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "afd1c09fa0ccd7c5905f2f086b1a5b2e45e44f01c0e1a4e84035adbda4367c5a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.6/arugula-0.68.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5c3736ed628b2ab230415eaa7cffa026aceb67997398cdb0d17b65df5b972976"
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
