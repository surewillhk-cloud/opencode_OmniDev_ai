# CodeNexus v5.2 - AI-Driven Development Team

> LLM-powered code generation team built on OpenCode architecture
> 
> Architecture: Agent handles orchestration, Skill provides expertise - fully decoupled and independently replaceable.

---

## 核心机制 (Core Mechanisms)

| 机制 | 说明 |
|------|------|
| 🛡️ **角色强化** | 每个 Agent 每次唤醒必须声明身份 |
| 🔥 **API 冒烟测试** | 每个 API 必须用 curl 真实调用验证 |
| 📊 **5-Why 根因分析** | Bug 必须查根因，不只是表面现象 |
| ⚡ **主动测试** | 子模块完成即触发测试，无需等待 Stage 6 |

---

## 目录结构

```
project-root/
  AGENTS.md                    ← 全局规则 + 工作流控制器
  opencode.json                ← OpenCode 配置（Agent 权限）
  CHANGELOG.md                 ← 自动维护
  .opencode/
    agent/                     ← 5 核心 Agents
      orchestrator.md          ← 工作流编排（v5.2 含主动测试）
      product-manager.md       ← 需求分析（v5.2 角色强化）
      ui-designer.md         ← UI 设计（v5.2 状态覆盖标准）
      fullstack-dev.md       ← 全栈开发（v5.2 API 冒烟测试）
      qa-tester.md          ← 测试验证（v5.2 5-Why 根因分析）

    skills/                    ← 22 Skills（关键词触发）
      prd-methodology/         ← PRD 写作标准
      changelog-format/         ← CHANGELOG 格式
      ui-figma-playbook/       ← Figma 提示指南
      ui-imagen-guide/         ← Imagen 4 指南
      ui-aistudio-guide/       ← AI Studio 提示指南
      dev-standards/           ← 代码标准 + 原型规范化（v5.2）
      test-checklist/           ← 测试清单（v5.2 含 TDD/E2E）
      architecture-design/    ← 架构设计
      code-generation/        ← 代码生成
      security-audit/         ← 安全审计
      security-project/        ← 安全项目（新增）
      devops-automation/      ← DevOps 自动化
      code-refactoring/       ← 重构模式
      web-design-guidelines/  ← Web 设计最佳实践
      composition-patterns/   ← React 组合模式
      vercel-deploy/          ← Vercel 部署
      token-economics/         ← Token 经济
      protocol-design/         ← 协议设计
      mvp-sequencing/         ← MVP 开发顺序
      blockchain-standards/   ← 区块链开发
      x-content-strategy/     ← X 内容策略
      agent-creator/          ← Agent 创建指南

  docs/                        ← AI 生成的文档
  prototypes/                  ← AI Studio 原型代码
```

---

## Agent 团队（5 核心）

| Agent | 功能 | 触发关键词 |
|-------|------|-----------|
| **orchestrator** | 工作流编排，管理流水线 | workflow 相关 |
| **product-manager** | 需求分析，PRD 输出 | "我想做"、"需求" |
| **ui-designer** | UI 设计提示生成 | "UI"、"设计"、"原型" |
| **fullstack-dev** | 任何代码开发任务 | "开发"、"实现"、"写代码" |
| **qa-tester** | 测试、验证、根因分析 | "测试"、"验证" |

---

## 使用方法

### 方式一：完整产品开发（自动流程）

描述需求，系统自动调度 agents：

```
我想做一个用户管理系统
```

Orchestrator 自动流程：product-manager → ui-designer → fullstack-dev → qa-tester

### 方式二：直接调用 Agent

使用 `@agent-name` 直接调用：

```
@product-manager 我需要电商系统的 PRD
@ui-designer 设计商品详情页 UI
@fullstack-dev 实现购物车功能
@qa-tester 测试结账流程
```

### 方式三：关键词触发 Skills（自动加载）

无需手动指定 Skills - Agent 根据关键词自动加载：

| 请求示例 | 自动加载的 Skill |
|---------|-----------------|
| "构建分布式架构系统" | `architecture-design` |
| "编写带安全审计的代码" | `security-audit` |
| "部署到 Vercel" | `devops-automation` |
| "重构这个模块" | `code-refactoring` |
| "设计区块链结算" | `blockchain-standards` |

### 方式四：组合使用

```
@fullstack-dev 构建交易系统，部署到 Vercel，带安全审计
```

fullstack-dev 会自动加载 `devops-automation` + `security-audit` Skills

---

## Skill 映射

| Skill | 关键词 | 用途 |
|-------|--------|------|
| `prd-methodology` | PRD 相关 | PRD 写作 |
| `changelog-format` | CHANGELOG | Changelog 维护 |
| `ui-figma-playbook` | Figma | Figma 提示 |
| `ui-imagen-guide` | 图像生成 | Imagen 提示 |
| `ui-aistudio-guide` | 原型 | AI Studio 提示 |
| `dev-standards` | 代码开发 | 代码标准 |
| `test-checklist` | 测试 | 测试清单 |
| `security-project` | 安全项目 | 安全项目规范（新增）|
| `architecture-design` | 架构、技术选型 | 架构设计 |
| `code-generation` | 生成、创建、实现 | 代码生成 |
| `security-audit` | 安全、漏洞、审计 | 安全审计 |
| `devops-automation` | 部署、CI/CD、Docker | DevOps |
| `code-refactoring` | 重构、优化 | 重构 |
| `blockchain-standards` | 区块链、智能合约 | 区块链开发 |
| `mvp-sequencing` | MVP、路线图 | MVP 规划 |

---

## 解耦架构

### 架构图

```
用户请求
    ↓
[关键词检测] ←→ Skill 知识库
    ↓
Orchestrator 决定调用哪个 Agent
    ↓
Agent 执行任务（自动注入相关 Skill 上下文）
```

### 优势

- 想改变测试方法论 → 只需替换 `test-checklist/SKILL.md`
- 想添加新语言/框架 → 只需替换 `code-generation/SKILL.md` + `dev-standards/SKILL.md`
- 想使用不同安全标准 → 只需替换 `security-audit/SKILL.md`
- **Agent 定义保持不变**

---

## Agent 调用优先级

### 简单任务（快速开发）
```
@fullstack-dev → @qa-tester
```

### 完整产品开发
```
@product-manager → @ui-designer → @fullstack-dev → @qa-tester
```

### 架构 + 开发 + 部署
```
@product-manager → @ui-designer → @fullstack-dev (加载 architecture-design + devops-automation) → @qa-tester
```

### 重构 + 安全审计
```
@fullstack-dev (加载 code-refactoring + security-audit) → @qa-tester
```

---

## 版本历史

| 版本 | 变更 |
|------|------|
| **v5.2** | 🛡️ 角色强化机制、🔥 API 冒烟测试、📊 5-Why 根因分析、⚡ 主动测试、新增 security-project skill |
| v5.1 | 简化为 5 核心 Agents，Skills 添加关键词触发解耦加载 |
| v5 | 添加 5 个 LLM 代码生成 Agents + 5 个 Skills |
| v4 | Agent + Skill 解耦架构 |
| v3 | 基于角色的硬切换 |

---

## 安装

```bash
# 复制到新项目
cp -r .opencode /your/project/path/
cp AGENTS.md /your/project/path/
cp opencode.json /your/project/path/
```

---

## 在 OpenCode 中使用

```bash
cd /path/to/project
opencode
```

或指定使用 orchestrator agent：

```bash
opencode --agent orchestrator
```

---

*Built on OpenCode Agent + Skill architecture | v5.2*
