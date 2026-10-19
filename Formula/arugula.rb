# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.47.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.47.0/arugula-0.47.0-x86_64-apple-darwin.tar.gz"
      sha256 "4df1d00bf4ee71a40e2a23bbf31fe59499c5ad0d8d087b41d09b30de7f632c19"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.47.0/arugula-0.47.0-aarch64-apple-darwin.tar.gz"
      sha256 "0a812417a332af73a3274ddcea4159c1f4d57eced9fd245dc29ee9eded87089b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.47.0/arugula-0.47.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d6deb3480bd1d1c8065aa42f5a1ede095ded7aad979fe28e23867af1a1886add"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.47.0/arugula-0.47.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "59e4c9d8af99a049abd2111a8891c3b7b3fc92fc52a83b5ae797a95ab58df687"
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
