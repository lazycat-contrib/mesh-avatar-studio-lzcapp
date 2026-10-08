# Mesh Avatar Studio (LazyCat)

3D 二次元头像工作室：网格编辑、口型同步、直播推流，打包为 LazyCat LPK v2 静态应用。上游项目：[shinshin86/mesh-avatar-studio](https://github.com/shinshin86/mesh-avatar-studio)。

## 部署信息

- **包名**：`cloud.lazycat.app.mesh-avatar`
- **版本**：跟随上游 main 分支自动更新（每日 UTC 02:00 检查，北京时间 10:00）
- **类型**：纯静态站（Vite + React 构建，无后端服务；媒体处理在浏览器端完成）
- **min_os_version**：1.5.0
- **内容**：约 36 MB（含 MediaPipe 视觉资源与示例模型）

## 页面入口

- `/`：编辑器（index.html）
- `/stream.html`：推流页
- `/live.html`：直播页

## 自动更新机制

上游没有 release tag，`sync-upstream` job 每日比对 main 分支 HEAD commit SHA（`.upstream-sha` 记录上次构建值），变化则 bump patch（1.0.0 → 1.0.1 …）并 push 触发发布。

```
上游 shinshin86/mesh-avatar-studio (main)
   │  schedule 检查 HEAD SHA → 变化则 bump patch → push
   ▼
本仓库（LPK 配置 + build.sh）
   │  push 触发 → ca-x/lazycat-github-action（node 22 toolchain）
   │  buildscript: clone 上游 → npm ci → vite build → site/
   ▼
LPK 打包（contentdir: ./site）→ GitHub Release + 喵喵商店发布
```
