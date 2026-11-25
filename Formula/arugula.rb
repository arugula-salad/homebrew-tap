# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.104"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.104/arugula-0.70.104-x86_64-apple-darwin.tar.gz"
      sha256 "189253c9e0f83265547ee1fad5dabc57a2c1884da30644195ccbc8d45ec83aaf"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.104/arugula-0.70.104-aarch64-apple-darwin.tar.gz"
      sha256 "1e30e3f263969ea9d93a5cd23ebd14bc3d3327cf65708f37c1fd49ff0dc17a2a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.104/arugula-0.70.104-x86_64-unknown-linux-musl.tar.gz"
      sha256 "73e175a38072d9412f1c42183ae0c8d8528ee2b0b3bbbcc9c2eea0edbb77867d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.104/arugula-0.70.104-aarch64-unknown-linux-musl.tar.gz"
      sha256 "74a9085f36a553db341386ba0ef37182a76dd3a562ffb00e2c8bb9a64bc39c76"
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
