# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.51.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.51.0/arugula-0.51.0-x86_64-apple-darwin.tar.gz"
      sha256 "5ad0130d20c9696b63fbeada5019d4d3260ec8b38ad26cd479686d48da9ffc14"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.51.0/arugula-0.51.0-aarch64-apple-darwin.tar.gz"
      sha256 "9717677c9701192edcdf730071ff87dc15c542cd8116baed83660615592e062a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.51.0/arugula-0.51.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "90abf7f12784e4bc45d2b38b16e322cb76edf1eedeef28881a997b2da77885cd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.51.0/arugula-0.51.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "40febd807293d7b5110bbf64acfb88030c86ba4d56a810d500a41f495fafe4cc"
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
