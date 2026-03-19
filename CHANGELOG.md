# CHANGELOG - CodeNexus

所有重大变更都会记录在此文件中。

---

## [5.2.2] - 2026-03-20

### 新增

- **.env.example**: 框架保护口令配置示例
- **scripts/smoke-test.sh**: API 冒烟测试自动化脚本
- **QUICKSTART.md**: 快速入门指南

### 优化

- **opencode.json**: 添加框架文件保护规则
  - AGENTS.md, opencode.json, .opencode/**, scripts/**, .env 设置为 edit/write deny
  - 口令验证保护机制

### 修复

- **Skills keywords**: 为 6个缺少 metadata.keywords 的 Skill 补充
  - vercel-deploy, web-design-guidelines, composition-patterns
  - token-economics, protocol-design, x-content-strategy
- **opencode.json**: product-manager 和 ui-designer 添加 skill 工具

---

## [5.2.1] - 2026-03-20

### 新增

- **api-design skill**: REST API 设计规范
- **scripts/smoke-test.sh**: API 冒烟测试脚本

### 优化

- **Stage 评审机制**: 添加通过标准和最大 3 轮限制
- **README.md**: Skill 映射表更新到 23个 Skills

### 修复

- Skills keywords 缺失问题

---

## [5.2.0] - 2026-03-20

### 新增

#### Agents
- **orchestrator.md**: 主动测试触发机制
  - 子模块完成即触发测试，无需等待 Stage 6
  - API 冒烟测试触发规则
  - 质量门禁机制

- **fullstack-dev.md**: API 冒烟测试
  - 每个 API 必须 curl 真实调用验证
  - API 开发模板（Zod 验证）
  - 开发伴随测试机制

- **qa-tester.md**: 5-Why 根因分析
  - 强制 5-Why 分析模板
  - 根因分类表
  - Bug 报告模板 v5.2

- **product-manager.md**: 角色强化
  - 每次唤醒必须声明身份
  - 需求澄清标准

- **ui-designer.md**: 角色强化 + 状态覆盖标准
  - 每次唤醒必须声明身份
  - Loading/Empty/Error 状态强制覆盖

#### Skills
- **security-project** (NEW): 安全项目开发规范
  - 合规性注入（代码头部元数据）
  - 避障语义引导
  - 沙箱假设（默认 127.0.0.1）
  - 术语转换表
  - 操作留痕规范
  - 数据与隐私保护（OPSEC）

- **test-checklist** (ENHANCED): v5.2
  - 新增 TDD 铁律
  - 新增测试反模式
  - 新增 E2E 测试指南（Playwright）
  - 新增测试类型总览表

- **dev-standards** (ENHANCED): v5.2
  - 新增 API 冒烟测试流程
  - 新增 Zod 验证标准
  - 新增 API 文件模板

### 优化

- **orchestrator.md**: Skill 注入从硬编码改为解耦机制
  - 移除硬编码 Skill 触发表
  - 改为动态匹配参考

- **AGENTS.md**: 纳入新机制
  - 更新 Logo 到 v5.2
  - 新增四大核心机制说明
  - 新增质量门禁标准

- **opencode.json**: 同步更新
  - qa-tester 新增 curl/node bash 权限
  - description 更新到 v5.2

### 修复

- 修复 Skill 与 Agent 硬耦合问题

---

## [5.1.0] - 2025-XX-XX

### 新增
- 简化为 5 核心 Agents
- Skills 添加关键词触发解耦加载

### 变更
- Agent 数量从更多简化为 5 个

---

## [5.0.0] - 2025-XX-XX

### 新增
- 添加 5 个 LLM 代码生成 Agents
- 添加 5 个 Skills

---

## [4.0.0] - 2025-XX-XX

### 新增
- Agent + Skill 解耦架构

---

## [3.0.0] - 2025-XX-XX

### 新增
- 基于角色的硬切换

---

*遵循 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/) 规范*
