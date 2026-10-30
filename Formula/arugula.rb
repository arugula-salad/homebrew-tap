# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.2/arugula-0.66.2-x86_64-apple-darwin.tar.gz"
      sha256 "21e54de0125d78d786cecf5fe046de1875952e5cc1979fa29714910886e599dd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.2/arugula-0.66.2-aarch64-apple-darwin.tar.gz"
      sha256 "0464cd42e68ae8400557c2d807f7ad56966cd4ee04aa07a8e3458869a26ee275"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.2/arugula-0.66.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f73e1c2e5a5c19713f35fff567ee39acde3c9ce2720cce494240aeeefee3977d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.2/arugula-0.66.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "597722229a45d9ba2614f5fa3658db795ce58a890912c41e05445f224e243bc3"
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
