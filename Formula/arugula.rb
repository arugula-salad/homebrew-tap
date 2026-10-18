# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.46.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.1/arugula-0.46.1-x86_64-apple-darwin.tar.gz"
      sha256 "a3a00139d46827b61216d987d9c76ab264b82baa814f13400fcad87f38b6abe0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.1/arugula-0.46.1-aarch64-apple-darwin.tar.gz"
      sha256 "91312e83a2c7bd08d7da2fcfa5ad75378631a94757a58896bfb1ecbcac500332"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.1/arugula-0.46.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bc394820e2bec778696f836f285e8f67dbdb363b68fc34b4655806f418ba7c02"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.1/arugula-0.46.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4c6be0b6558f80d36140296561e23b9e5229ff17d162b369e0b7c40251b27ee5"
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
