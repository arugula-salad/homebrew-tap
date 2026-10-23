# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.3/arugula-0.60.3-x86_64-apple-darwin.tar.gz"
      sha256 "f2d66320b076b8da7a848b8608997bf5701d4d553622fd3a148114977e23317f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.3/arugula-0.60.3-aarch64-apple-darwin.tar.gz"
      sha256 "496a78a3e353be0abf1e63d9c982a69c066f3434e1ee4f2adea95a76d9c96e37"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.3/arugula-0.60.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1545de3476c564341e68125b0d6ede4d49aa2e481101fb263a950896994e2625"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.3/arugula-0.60.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b7e57416c8a7cd332ea91d39088ce9f0fb8b1cb36f1efb7a23216ec8424d5faa"
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
