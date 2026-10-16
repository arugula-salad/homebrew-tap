# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.41.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.41.0/arugula-0.41.0-x86_64-apple-darwin.tar.gz"
      sha256 "7ee8a818478a74cf0355236f5fe9d99b227638b49bf5bdd5a1b26aead699673e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.41.0/arugula-0.41.0-aarch64-apple-darwin.tar.gz"
      sha256 "3b5862876978a0db5f238096d84503f403d4439f9bb7e337bf915647ae8225d4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.41.0/arugula-0.41.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9a60bf7611c101fee8c60cf5752bc52ce5c536f445445eb7d3349b92f939bf5c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.41.0/arugula-0.41.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4efbec6c7c232ce5c69a72886b6ff76da7082d3ed93169221cd47fc9e3e3affd"
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
