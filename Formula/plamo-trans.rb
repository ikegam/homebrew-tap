# Homebrew formula for ikegam/homebrew-tap (installs the prebuilt release binaries).
# Version and checksums are filled in by packaging/update.sh on release.
class PlamoTrans < Formula
  desc "Local translation as a Unix filter: PLaMo 3 Translate on llama.cpp, no server"
  homepage "https://github.com/ikegam/plamo-trans"
  version "0.1.0"
  license all_of: ["BSD-4-Clause", "MIT"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/ikegam/plamo-trans/releases/download/v#{version}/plamo-trans-#{version}-macos-arm64.tar.gz"
    sha256 "9490b07085ef6f97cc2ef1c9f1bc4b3cadacba8a79eba4e0590f0fadbb21e36f" # macos-arm64
  end

  on_linux do
    on_intel do
      url "https://github.com/ikegam/plamo-trans/releases/download/v#{version}/plamo-trans-#{version}-linux-x86_64.tar.gz"
      sha256 "345c24eb043d560c7c8a800e41cce9f3f890d6a7bface1944b6e54a45ba66ecc" # linux-x86_64
    end
    on_arm do
      url "https://github.com/ikegam/plamo-trans/releases/download/v#{version}/plamo-trans-#{version}-linux-arm64.tar.gz"
      sha256 "bd38ce7763aaf8c7bcba7901c6d02409e0c3b9edafffc75d35734070d364c5a5" # linux-arm64
    end
  end

  def install
    bin.install "trs"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      The model is not included. Read the PLaMo Community License, then download one:
        trs --download 8b      # 5.3 GB, the default
        trs --download 0.8b    # 0.6 GB, for -ff
      https://huggingface.co/pfnet/plamo-3-translate-31b-GGUF
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/trs -V")
  end
end
