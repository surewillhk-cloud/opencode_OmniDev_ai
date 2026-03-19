# CodeNexus v5.2 快速入门指南

## 前提条件

1. 安装 OpenCode
2. 配置本地 LLM 模型（如 MiniMax、Ollama、LM Studio）

## 快速开始

### 1. 进入项目目录

```bash
cd /path/to/your/project
opencode
```

### 2. 呼出指挥官

在 OpenCode 中描述你的需求：

```
我想做一个用户管理系统
```

系统会自动：
1. 呼出 Orchestrator（指挥官）
2. 加载 AGENTS.md 和 orchestrator.md
3. 进入 Stage 1：需求阶段

### 3. 完整开发流程

```
Stage 1: 需求
  ↓ 描述需求
Stage 2: 需求评审（可选）
  ↓ 评审后决策
Stage 3: UI 设计
  ↓ 生成 UI prompts
Stage 4: UI 评审（可选）
  ↓ 评审后决策
Stage 5: 开发
  ↓ fullstack-dev 开发
Stage 6: 测试
  ↓ 伴随测试 + 修复 Bug
Stage 7: 交付
  ✅ 完成
```

---

## 使用场景

### 场景 1：完整产品开发

```
@orchestrator 我想做一个电商网站
```

### 场景 2：直接调用 Agent

```
@product-manager 我需要商品模块的 PRD
@ui-designer 设计商品详情页
@fullstack-dev 实现购物车功能
@qa-tester 测试结算流程
```

### 场景 3：带关键词触发 Skills

```
@fullstack-dev 用 React 实现用户模块，需要部署到 Vercel
```
→ 自动加载 `dev-standards` + `vercel-deploy` Skills

### 场景 4：快速修复 Bug

```
@fullstack-dev 登录接口返回 500 错误
@qa-tester 帮我验证修复是否成功
```

---

## Agent 说明

| Agent | 功能 | 触发方式 |
|-------|------|---------|
| **orchestrator** | 工作流编排 | 默认加载 |
| **product-manager** | 需求分析、PRD | "我想做"、"需求" |
| **ui-designer** | UI 设计提示 | "UI"、"设计" |
| **fullstack-dev** | 开发、DevOps | "开发"、"实现" |
| **qa-tester** | 测试、验证 | "测试"、"验证" |

---

## 核心机制

| 机制 | 说明 |
|------|------|
| 🛡️ 角色强化 | 每个 Agent 每次唤醒必须声明身份 |
| 🔥 API 冒烟测试 | 每个 API 必须 curl 真实调用 |
| 📊 5-Why 根因分析 | Bug 必须查根因 |
| ⚡ 主动测试 | 子模块完成即触发测试 |

---

## 常见问题

### Q: 如何跳过评审阶段？

A: 在评审后选择选项 C "忽略"，系统会进入下一阶段。

### Q: 如何查看当前阶段？

A: 呼出 orchestrator，它会显示当前阶段和可用操作。

### Q: 如何加载特定 Skill？

A: 在请求中包含关键词，如"部署"会触发 `vercel-deploy` Skill。

### Q: 测试发现 Bug 后怎么办？

A: Orchestrator 会自动通知 fullstack-dev 修复，修复后 qa-tester 执行回归测试。

---

## 目录说明

```
project/
├── docs/           ← PRD、UI 文档输出目录
├── prototypes/     ← AI Studio 原型代码
├── AGENTS.md      ← 全局规则
└── .opencode/
    ├── agent/     ← 5 个 Agent 定义
    └── skills/    ← 22 个 Skills（关键词触发）
```

---

*更多信息请参阅 [README.md](./README.md)*
