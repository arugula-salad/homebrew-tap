# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.34"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.34/arugula-0.70.34-x86_64-apple-darwin.tar.gz"
      sha256 "36c8e14f4e9f907d49e03f45905855c07243668c7506797106277f3939a04707"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.34/arugula-0.70.34-aarch64-apple-darwin.tar.gz"
      sha256 "a276831e23c6dd0e0b8d4afce58d395c826f09538bba417baeea00da96367394"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.34/arugula-0.70.34-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0676710dcea38b2cb6e3df7a12f950c756d82a2751b09d462e07128f0c7fb9c0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.34/arugula-0.70.34-aarch64-unknown-linux-musl.tar.gz"
      sha256 "723adb637ec7250c31b84c7e38a4259bea0b59bcea04bf07741fdbf7de55b283"
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
