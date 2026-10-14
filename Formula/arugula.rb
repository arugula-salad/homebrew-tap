# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.39.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.1/arugula-0.39.1-x86_64-apple-darwin.tar.gz"
      sha256 "2aa707e8ba295515752c9e1ffc63ed6f6298f58f2b01f6cd7deb088d837569ef"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.1/arugula-0.39.1-aarch64-apple-darwin.tar.gz"
      sha256 "0bec2ce5b9245dfc0e5496c630dc9c0ff5e0fa132df6ef1276237907c03e3d4e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.1/arugula-0.39.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6b417692a6e53fb83985b16fdc103d77337f735af4e12216d9e705e5cfd8ef86"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.1/arugula-0.39.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a44b671f84d6e0787c319a687c1385c48891dee280ae5372793e05a590585fff"
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
