# MultiScheduler

## 技術スタック

### フロントエンド

- Flutter(Android, Windows, Linux, Web)
iOSはAppleDeveloperProgramが高いため未対応
macOSは持っていないため未対応

### バックエンド

- FastAPI
docker(k8s)でデプロイする。

- Supabase (Authentication, Database[PostgreSQL])

## 環境構築

VSCodeのワークスペースを推奨
Workspace: `/MultiScheduler.code-workspace`

以下のツールをインストールし、PATHを通す。
- uv
- Flutter(fvm)
- Supabase CLI

依存関係をインストールする。
```
uv sync
```

### Supabaseの起動

以下のコマンドを `/` で実行する。

```bash
supabase start
```

### バックエンドの起動

以下のコマンドを `/backend` で実行する。

```bash
./scripts/dev.ps1
# または
./scripts/dev.sh
```

### フロントエンドの起動

flutterのデバッグを実行する。
