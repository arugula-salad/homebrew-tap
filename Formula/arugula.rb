# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.27.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.27.0/arugula-0.27.0-x86_64-apple-darwin.tar.gz"
      sha256 "ee908d44b7cfb247a02852b8b677cbd3ddee85f3952a2716eaca7a6f07fcf63f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.27.0/arugula-0.27.0-aarch64-apple-darwin.tar.gz"
      sha256 "d0c1e42993fed68ab389aeb45f2538f716c963fd9dfac200d38f3d82589c2cac"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.27.0/arugula-0.27.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d79fdc22b87acc95c92ca1e27182eb51926d1a8fccee60eecba2cc167b8d4642"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.27.0/arugula-0.27.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a81328367b9440ea81b0f992aff14f9e50a45be1fa890c3d853911a34bb4281f"
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
