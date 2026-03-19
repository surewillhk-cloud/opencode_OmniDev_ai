---
name: test-checklist
description: |
  Comprehensive testing skill including functional testing, API smoke testing, root cause analysis,
  boundary testing, security testing, and quality reporting. Used by QA testers.
  v5.2: 新增 TDD 原则、测试反模式、E2E 测试指南。
license: MIT
compatibility: opencode
metadata:
  keywords: "测试,test,测试用例,验证,边界,异常,回归测试,单元测试,集成测试,冒烟测试,根因分析,E2E,性能测试"
---

# Functional Testing Checklist v5.2

## 测试类型总览

| 测试类型 | 使用场景 | 执行者 |
|---------|---------|-------|
| API 冒烟测试 | 每个 API 创建/修改后 | fullstack-dev → qa-tester |
| 单元测试 | 核心业务逻辑 | fullstack-dev |
| 集成测试 | 模块间交互 | qa-tester |
| E2E 测试 | 完整用户流程 | qa-tester |
| 安全测试 | 认证/授权/注入 | qa-tester |
| 性能测试 | 大数据量/并发 | qa-tester |

---

## 每个模块必测项

### 正向流程
- [ ] 正常输入 → 预期输出符合 PRD 验收标准
- [ ] 完整用户流程走通（从入口到完成）

### 边界测试（全部必测）
- [ ] 空输入 / null / undefined → 友好提示
- [ ] 超长字符串（>1000字符）→ 截断或报错
- [ ] 特殊字符（`<script>alert(1)</script>`）→ XSS 安全
- [ ] SQL 注入字符（`' OR 1=1 --`）→ 安全
- [ ] 并发操作（快速连点提交 5 次）→ 不重复提交
- [ ] 网络中断后重试 → 接口幂等

### 异常流程
- [ ] API 返回 500 → 前端友好错误提示，不白屏
- [ ] Token 过期 → 正确跳转登录页
- [ ] 数据为空 → 显示 Empty State，不空白
- [ ] 文件上传失败 → 有提示

### 性能检查
- [ ] 列表超 100 条 → 不卡顿，有分页或虚拟滚动
- [ ] 首屏加载 → 有骨架屏
- [ ] Network 面板确认无重复请求

---

## 🔥 API 冒烟测试标准

### 测试环境准备

```bash
# 1. 确保服务器运行
pgrep -f "node.*dev" || npm run dev &

# 2. 等待服务器就绪
for i in {1..10}; do
  curl -s http://localhost:3000/health && break
  sleep 2
done
```

### 冒烟测试清单

| 测试类型 | 命令 | 验证点 |
|---------|------|-------|
| 健康检查 | `curl http://localhost:3000/health` | 状态码 200 |
| 成功路径 | `curl -X POST -d '{}'` | success=true, data 存在 |
| 验证失败 | `curl -X POST -d 'invalid'` | success=false, error.code='VALIDATION_ERROR' |
| 认证失败 | `curl -X POST /protected` | 状态码 401 |
| 边界空字符串 | `curl -d '""'` | 验证失败响应 |
| 边界超长 | `curl -d '"...1000+ chars"'` | 拒绝或截断 |

### 响应格式验证

```bash
# 验证标准格式
# 成功：{success: true, data: any}
# 失败：{success: false, error: {code: string, message: string}}
```

---

## 🧪 测试方法论

### TDD 铁律

| 阶段 | 行为 |
|------|------|
| 红 | 写一个失败的测试 |
| 绿 | 写最简单的代码让测试通过 |
| 重构 | 重构代码，保持测试通过 |

**核心原则**：
- 先写测试，再写实现
- 测试必须能捕获 Bug
- 保持测试简单和可维护

### 测试反模式

| 反模式 | 问题 | 正确做法 |
|--------|------|---------|
| 嘲讽外部依赖 | 测试不稳定 | 使用稳定的测试替身 |
| 顺序依赖测试 | 测试互相影响 | 确保测试独立 |
| 测试实现细节 | 重构破坏测试 | 只测试公开行为 |
| 覆盖而非验证 | 测试无用 | 测试有意义的结果 |

### E2E 测试指南

```typescript
// Playwright E2E 示例
import { test, expect } from '@playwright/test';

test('用户登录流程', async ({ page }) => {
  // 1. 导航到登录页
  await page.goto('/login');
  
  // 2. 填写表单
  await page.fill('[name="email"]', 'test@example.com');
  await page.fill('[name="password"]', 'password123');
  
  // 3. 提交
  await page.click('button[type="submit"]');
  
  // 4. 验证结果
  await expect(page).toHaveURL('/dashboard');
  await expect(page.locator('.user-name')).toHaveText('Test User');
});
```

---

## 📊 5-Why 根因分析

### 分析模板

每个 🔴🟡 Bug 必须执行 5-Why 分析：

```
Bug-[编号]：[表面现象]

为什么？
→ [原因 1]

为什么？
→ [原因 2]

为什么？
→ [原因 3]

为什么？
→ [原因 4]

为什么？
→ [根因]

修复建议：[针对根因的修复，不是治标]
```

### 根因分类表

| 根因类型 | 示例 | 修复方向 |
|---------|------|---------|
| 输入验证缺失 | 未校验空字符串 | 添加 Zod/Joi 验证 |
| 错误处理不当 | catch 块为空 | 添加错误处理逻辑 |
| 类型定义错误 | API 响应结构不一致 | 统一 DTO 定义 |
| 边界条件未处理 | 数组越界 | 添加边界检查 |
| 异步时序问题 | 先检查后使用被异步修改的值 | 添加等待/锁机制 |

---

## Bug 严重程度定义

| 级别 | 定义 | 处理要求 |
|------|------|---------|
| 🔴 严重 | 功能不可用、数据丢失、安全漏洞 | 必须修复才能继续 |
| 🟡 一般 | 功能部分异常、体验明显问题 | 本轮修复 |
| 🟢 轻微 | 视觉细节、文案错别字 | 可留下轮迭代 |

---

## 测试报告模板 v5.2

```markdown
## 🐛 Bug 报告 #[N]

### 基础信息
- **严重级别**：🔴 / 🟡 / 🟢
- **模块**：[模块名]
- **文件**：[文件路径]

### 问题描述
[清晰描述问题]

### 复现步骤
1. [步骤 1]
2. [步骤 2]
3. [步骤 3]

### 实际结果
[当前行为]

### 预期结果
[应该的行为]

### 根因分析（5-Why）

**表面现象**：[是什么]

**为什么？** → [原因 1]

**为什么？** → [原因 2]

**为什么？** → [原因 3]

**为什么？** → [原因 4]

**为什么？** → **[根因]**

### 修复建议
[针对根因的修复建议]

---

## 回归测试模板

```markdown
## 🔄 回归测试：BUG-[编号]

### 修复验证
- [ ] 原 Bug 已修复
- [ ] 相关边界条件仍正常
- [ ] 无新 Bug 引入

### 测试结果
✅ Pass / ❌ Fail

### 遗留问题（如有）
- [ ] [问题描述]
```
```

---

## 放行模板

```markdown
## ✅ 测试通过：[模块名]（第N轮）

### 测试覆盖率
- API 冒烟测试：100% 通过
- 边界测试：100% 通过
- 回归测试：无新问题

### Bug 状态
- 🔴 严重：0
- 🟡 一般：0
- 🟢 轻微：[N] 个

### 结论
本模块已达上线标准
遗留：[N] 个 🟢 轻微问题，不影响上线
```

---

## 🚫 测试禁止

- ❌ 不测试错误情况
- ❌ 使用生产数据
- ❌ 创建顺序依赖的测试
- ❌ 忽略不稳定的测试
- ❌ 测试实现细节
- ❌ 留下调试代码

---

**版本：v5.2 | TDD原则 | 测试反模式 | E2E指南 | OpenCode 原生**
