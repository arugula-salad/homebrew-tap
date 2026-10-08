# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.28.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.28.0/arugula-0.28.0-x86_64-apple-darwin.tar.gz"
      sha256 "14b4bfb2dd352eb24a4fb2dfeed766256df4850aabc710328b3466978bf276ff"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.28.0/arugula-0.28.0-aarch64-apple-darwin.tar.gz"
      sha256 "d48f8b17c84090a60bf1e1b28ac61ae4e036165fae0402d3a94679a9830180dd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.28.0/arugula-0.28.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "01e63f9d405d9c32236380961137d0011417a164413454be42f129de19e78ae3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.28.0/arugula-0.28.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "187ae657cd71a758af09dc6ca7e1275a04ec5f55086533fd6ba5495889d73c74"
    end
  end

  def install
    bin.install "arugulad", "arugula"
    # The old names, for hooks and scripts that call them (#505, drop in
    # #508). The formula was `illogical`; the tap's formula_renames.json
    # moves its installs here.
    bin.install_symlink "arugulad" => "illogicald"
    bin.install_symlink "arugula" => "illogical"
  end

  def caveats
    <<~EOS
      Start the daemon as a service (a launchd agent on macOS, a systemd
      user unit on Linux), and again after each upgrade:
        arugulad install
      Coming from illogical: that replaces the illogicald service with
      arugulad's, keeping your panes, state and settings.
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
