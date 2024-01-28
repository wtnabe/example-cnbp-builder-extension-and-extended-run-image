## An example of Cloud Native Buildpacks extensions and extended run-image

### できること

Cloud Native Buildpacks を利用して、既存のイメージに存在しないパッケージを利用した gem をインストール、これを利用した ruby プログラムを動作させる。

 * google-22 builder を使い、build image をオリジナルの buildpack と extension で拡張する
 * google-22 builder の run image を親に持つ run image をビルドする
 * 結果、クラウド上で Ruby + gdbm / rocksdb を利用したイメージを動かす

### 注意

2024-01-28 時点でメジャーどころでは google-22 builder でしか動かない。

Google のドキュメント[^1]によると既存の builder image を親に持つイメージを自分で作れば使えそうだが、 実際やってみると "could not parse reference" と言われる。

[^1]: [Configure your build and run images  \|  Buildpacks  \|  Google Cloud](https://cloud.google.com/docs/buildpacks/build-run-image)

#### 確認環境

 * macOS ( arm64 )
 * colima 0.6.7
 * Docker
    * Client 25.0.0
    * Server 24.0.7
 * pack 0.32.1+git-b14250b.build-5241
 * Google Cloud Run

### 目的

 * default の build image, run image の両方に必要なパッケージを追加して Ruby の native extension をビルドし、動かす

### 準備

 * Docker環境
    * 恐らく ARM 向けは不可
    * colima + qemu + amd64 は OK
 * packコマンド
    * [pack · Cloud Native Buildpacks](https://buildpacks.io/docs/tools/pack/cli/pack/)
    * [buildpacks/pack: CLI for building apps using Cloud Native Buildpacks](https://github.com/buildpacks/pack)

### 使い方

```
$ ./bin/prepare-images
$ ./bin/build
```

あとは動かしたいプラットフォーム向けに build 済みの docker image を push したりなんだりしてください。

### 今回やっていないこと / できなかったこと

 * 独自 builder をゼロから作る
     * builder を作る場合、buildpack の指定をゼロから全部やらなきゃいけないので面倒くさい。できるだけやりたくない。

[Buildpacksのビルダーをスクラッチから作ってみる \| フューチャー技術ブログ](https://future-architect.github.io/articles/20201002/)

 * 公式のドキュメントでは extension で run image の拡張ができそうに見えるのだが、それはできなかった

[Generating a run\.Dockerfile that extends the runtime base image · Cloud Native Buildpacks](https://buildpacks.io/docs/extension-guide/create-extension/run-dockerfile-extend/)

