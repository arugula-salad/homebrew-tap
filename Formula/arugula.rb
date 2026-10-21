# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.55.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.55.1/arugula-0.55.1-x86_64-apple-darwin.tar.gz"
      sha256 "801a299346bfb1cb68f56f62dde5cb4351742205b2dff1abe7880ef5312b75eb"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.55.1/arugula-0.55.1-aarch64-apple-darwin.tar.gz"
      sha256 "5eb2fd2f3b6b307ac1f01b6f754361e750169d1af050f6742a5a7e3d84418874"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.55.1/arugula-0.55.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "45a26bd047b46e94b7142a5969383a8173b4ad0ad903ed68fa80a75be83cea7a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.55.1/arugula-0.55.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ea41b93f672afa449776f806c35ae98d34371ee98409b1e4196fe51d6efe07d9"
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
