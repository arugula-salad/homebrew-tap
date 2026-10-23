# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.1/arugula-0.60.1-x86_64-apple-darwin.tar.gz"
      sha256 "8aa4cb7aaca1a35007efd6eb9ea3e90984e8500bbe3689452269a2eb936ecd2e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.1/arugula-0.60.1-aarch64-apple-darwin.tar.gz"
      sha256 "6604cae1d6e0ad9a615d8b43d679eb8ec5699300dd178a79a18593a778a33ef2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.1/arugula-0.60.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8f09dadad3d8269d61a7eacada58b12109cb0abbb8ec99b8a02ea265b76fc21e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.1/arugula-0.60.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a0a5c34ca2f1299a62bc0cd60b82cd0382f959c51cdf333cc10f66d1fd47b92d"
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
