# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.54.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.54.0/arugula-0.54.0-x86_64-apple-darwin.tar.gz"
      sha256 "b318e4089680b97ef84975b52f9ce7879ec26ea434fcbaa54601c177a99fc5da"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.54.0/arugula-0.54.0-aarch64-apple-darwin.tar.gz"
      sha256 "6a9ee39844272ce1373253528f02a509a479ea06a42dbe0027529e34724b689b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.54.0/arugula-0.54.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "48b9cbac1329fb8199690985dad3e6d2822af4cdf1f598e3bfa9a68886e1b7a3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.54.0/arugula-0.54.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f9496512bec2c879078e3b309b848565765a7aa81b1798f7641f883510ea868e"
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
