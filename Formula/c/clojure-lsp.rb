class ClojureLsp < Formula
  desc "Language Server (LSP) for Clojure"
  homepage "https://github.com/clojure-lsp/clojure-lsp"
  url "https://github.com/clojure-lsp/clojure-lsp/releases/download/2023.10.30-16.25.41/clojure-lsp-standalone.jar"
  version "20231030T162541"
  sha256 "4e2fadf51e6b1e64b7b532d6650726f49f438e92f714b34e206268d6503c3370"
  license "MIT"
  head "https://github.com/clojure-lsp/clojure-lsp.git", branch: "master"

  livecheck do
    url :stable
    regex(%r{^(?:release[._-])?v?(\d+(?:[T/.-]\d+)+)$}i)
    strategy :git do |tags, regex|
      # Convert tags like `2021.03.01-19.18.54` to `20210301T191854` format
      tags.map { |tag| tag[regex, 1]&.gsub(".", "")&.gsub(%r{[/-]}, "T") }.compact
    end
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c4b1bf6d88ac898514835afd5d4bc6eebed167868db83e715e7465732bdc1583"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2d4e690d36e34f8a666792a1033fd31353788741fc9011f55ea129ca8496f4d9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0a4a35ec9ddf2b5d408e43f1b7225d50c3032d4a9e2029ed8a373ee5a2de780d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "90574ce478618d645bfcbb07b46247f75b94a581eb231dd4c1b84f49d96be60c"
    sha256 cellar: :any_skip_relocation, sonoma:         "d0b29e452cd84fc891ab21452a434e6fbb6466c57f4d9ce1fbeeedda752dd501"
    sha256 cellar: :any_skip_relocation, ventura:        "8723827e35fe27ad0728200296abd4b12c58d6a7ba7f755bf15fdb72e0446277"
    sha256 cellar: :any_skip_relocation, monterey:       "0fcb5934f6cb322d11d73836327ba84e7edbf5ba3e1af081fe5b993239491eeb"
    sha256 cellar: :any_skip_relocation, big_sur:        "ba891cc1306683265d67cac7c91cd99bba90bc3e79db6174cca325c952b6f07d"
    sha256 cellar: :any_skip_relocation, catalina:       "94a41008e212ff412f36227d2f439a2a6636b16b3a4331e1c5e93a2fb601936f"
    sha256 cellar: :any_skip_relocation, mojave:         "26545581a5a5fc5ea13bb252ee4c76eb10284b25f9102335e93e7971548d05a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5b8f92dadb82afd0bee547349f330a415c9fd1d8ab8ed80c58495b02c6f140e0"
  end

  depends_on "openjdk"

  def install
    libexec.install "clojure-lsp-standalone.jar"
    bin.write_jar_script libexec/"clojure-lsp-standalone.jar", "clojure-lsp"
  end

  test do
    require "open3"

    json = <<~JSON
      {
        "jsonrpc": "2.0",
        "id": 1,
        "method": "initialize",
        "params": {
          "processId": 88075,
          "rootUri": null,
          "capabilities": {},
          "trace": "verbose",
          "workspaceFolders": null
        }
      }
    JSON

    Open3.popen3("#{bin}/clojure-lsp") do |stdin, stdout|
      stdin.write "Content-Length: #{json.size}\r\n\r\n#{json}"
      assert_match(/^Content-Length: \d+/i, stdout.readline)
    end
  end
end
